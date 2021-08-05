import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  var isShowEmoji = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late FocusNode focusNode;
  late TextEditingController chatC;

  void addEmojiToChat(Emoji emoji) {
    chatC.text = chatC.text + emoji.emoji;
  }

  void deleteEmoji() {
    chatC.text = chatC.text.substring(0, chatC.text.length - 2);
  }

  void newChat(String email, Map<String, dynamic> argument, String chat) {
    CollectionReference chats = firestore.collection("chats");

    chats.doc(argument["chat_id"]).collection("chat").add({
      "pengirim": email,
      "penerima": argument["friendEmail"],
      "msg": chat,
      "time": DateTime.now().toIso8601String(),
      "isRead": false,
    });
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
