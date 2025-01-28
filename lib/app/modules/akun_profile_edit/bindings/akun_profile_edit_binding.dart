import 'package:get/get.dart';

import '../controllers/akun_profile_edit_controller.dart';

class AkunProfileEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AkunProfileEditController>(
      () => AkunProfileEditController(),
    );
  }
}
