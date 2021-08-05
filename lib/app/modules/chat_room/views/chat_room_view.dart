import 'package:chatapp/app/controllers/auth_controller.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        leadingWidth: 100,
        leading: InkWell(
          onTap: () => Get.back(),
          borderRadius: BorderRadius.circular(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 5),
              Icon(Icons.arrow_back),
              SizedBox(width: 5),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: Image.asset("assets/logo/noimage.png"),
              ),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lorem Ipsum',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'statusnya lorem',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: WillPopScope(
        onWillPop: () {
          if (controller.isShowEmoji.isTrue) {
            controller.isShowEmoji.value = false;
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    ItemChat(
                      isSender: true,
                    ),
                    ItemChat(
                      isSender: false,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: controller.isShowEmoji.isTrue
                    ? 5
                    : context.mediaQueryPadding.bottom,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: TextField(
                        controller: controller.chatC,
                        focusNode: controller.focusNode,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: () {
                              controller.focusNode.unfocus();
                              controller.isShowEmoji.toggle();
                            },
                            icon: Icon(Icons.emoji_emotions_outlined),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Material(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red[900],
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () => controller.newChat(
                        authC.user.value.email!,
                        Get.arguments as Map<String, dynamic>,
                        controller.chatC.text,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => (controller.isShowEmoji.isTrue)
                  ? Container(
                      height: 325,
                      child: EmojiPicker(
                        onEmojiSelected: (category, emoji) {
                          controller.addEmojiToChat(emoji);
                        },
                        onBackspacePressed: () {
                          controller.deleteEmoji();
                        },
                        config: Config(
                          backspaceColor: Color(0xFFB71C1C),
                          columns: 7,
                          emojiSizeMax: 32.0,
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          initCategory: Category.RECENT,
                          bgColor: Color(0xFFF2F2F2),
                          indicatorColor: Color(0xFFB71C1C),
                          iconColor: Colors.grey,
                          iconColorSelected: Color(0xFFB71C1C),
                          progressIndicatorColor: Color(0xFFB71C1C),
                          showRecentsTab: true,
                          recentsLimit: 28,
                          noRecentsText: "No Recents",
                          noRecentsStyle: const TextStyle(
                              fontSize: 20, color: Colors.black26),
                          categoryIcons: const CategoryIcons(),
                          buttonMode: ButtonMode.MATERIAL,
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemChat extends StatelessWidget {
  const ItemChat({
    Key? key,
    required this.isSender,
  }) : super(key: key);

  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: isSender
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
            ),
            padding: EdgeInsets.all(15),
            child: Text(
              "Haloo selamat datang",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text("18:22 PM"),
        ],
      ),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    );
  }
}
