import 'package:get/get.dart';

import '../controllers/update_status_controller.dart';

class UpdateStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateStatusController>(
      () => UpdateStatusController(),
    );
  }
}
