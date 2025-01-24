import 'package:get/get.dart';

import '../controllers/program_all_controller.dart';

class ProgramAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgramAllController>(
      () => ProgramAllController(),
    );
  }
}
