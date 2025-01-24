import 'package:get/get.dart';

import '../controllers/jamaah_controller.dart';

class JamaahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JamaahController>(
      () => JamaahController(),
    );
  }
}
