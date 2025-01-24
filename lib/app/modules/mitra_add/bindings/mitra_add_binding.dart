import 'package:get/get.dart';

import '../controllers/mitra_add_controller.dart';

class MitraAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MitraAddController>(
      () => MitraAddController(),
    );
  }
}
