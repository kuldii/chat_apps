import 'package:get/get.dart';

import '../controllers/chat_room_controller.dart';

class ChatRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatRoomController>(
      () => ChatRoomController(),
    );
  }
}
