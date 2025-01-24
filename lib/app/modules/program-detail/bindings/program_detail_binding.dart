import 'package:get/get.dart';

import '../controllers/program_detail_controller.dart';

class ProgramDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgramDetailController>(
      () => ProgramDetailController(),
    );
  }
}
