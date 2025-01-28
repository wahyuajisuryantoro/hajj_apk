import 'package:get/get.dart';

import '../controllers/akun_password_edit_controller.dart';

class AkunPasswordEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AkunPasswordEditController>(
      () => AkunPasswordEditController(),
    );
  }
}
