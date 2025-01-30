import 'package:get/get.dart';

import '../controllers/dashboard_detail_program_controller.dart';

class DashboardDetailProgramBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardDetailProgramController>(
      () => DashboardDetailProgramController(),
    );
  }
}
