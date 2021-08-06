import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  var isShowEmoji = false.obs;
  int total_unread = 0;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late FocusNode focusNode;
  late TextEditingController chatC;

  void addEmojiToChat(Emoji emoji) {
    chatC.text = chatC.text + emoji.emoji;
  }

  void deleteEmoji() {
    chatC.text = chatC.text.substring(0, chatC.text.length - 2);
  }

  void newChat(String email, Map<String, dynamic> argument, String chat) async {
    CollectionReference chats = firestore.collection("chats");
    CollectionReference users = firestore.collection("users");

    String date = DateTime.now().toIso8601String();

    final newchat =
        await chats.doc(argument["chat_id"]).collection("chat").add({
      "pengirim": email,
      "penerima": argument["friendEmail"],
      "msg": chat,
      "time": date,
      "isRead": false,
    });

    await users.doc(email).collection("chats").doc(argument["chat_id"]).update({
      "lastTime": date,
    });

    final checkChatsFriend = await users
        .doc(argument["friendEmail"])
        .collection("chats")
        .doc(argument["chat_id"])
        .get();

    if (checkChatsFriend.exists) {
      // exist on friend DB
      // first check total unread
      final checkTotalUnread = await chats
          .doc(argument["chat_id"])
          .collection("chat")
          .where("isRead", isEqualTo: false)
          .where("pengirim", isEqualTo: email)
          .get();

      // total unread for friend
      total_unread = checkTotalUnread.docs.length;

      await users
          .doc(argument["friendEmail"])
          .collection("chats")
          .doc(argument["chat_id"])
          .update({"lastTime": date, "total_unread": total_unread});
    } else {
      // not exist on friend DB
      await users
          .doc(argument["friendEmail"])
          .collection("chats")
          .doc(argument["chat_id"])
          .set({
        "connection": email,
        "lastTime": date,
        "total_unread": 1,
      });
    }
  }

  @override
  void onInit() {
    chatC = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    chatC.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
