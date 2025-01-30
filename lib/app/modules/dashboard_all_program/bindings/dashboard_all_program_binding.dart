import 'package:get/get.dart';

import '../controllers/dashboard_all_program_controller.dart';

class DashboardAllProgramBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardAllProgramController>(
      () => DashboardAllProgramController(),
    );
  }
}
