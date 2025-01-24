import 'package:get/get.dart';

import '../controllers/mitra_controller.dart';

class MitraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MitraController>(
      () => MitraController(),
    );
  }
}
