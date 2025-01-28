import 'package:get/get.dart';

import '../controllers/jamaah_list_controller.dart';

class JamaahListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JamaahListController>(
      () => JamaahListController(),
    );
  }
}
