import 'package:get/get.dart';

import '../controllers/berita_all_controller.dart';

class BeritaAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BeritaAllController>(
      () => BeritaAllController(),
    );
  }
}
