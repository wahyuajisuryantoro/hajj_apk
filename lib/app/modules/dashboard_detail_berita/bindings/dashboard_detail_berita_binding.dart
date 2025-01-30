import 'package:get/get.dart';

import '../controllers/dashboard_detail_berita_controller.dart';

class DashboardDetailBeritaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardDetailBeritaController>(
      () => DashboardDetailBeritaController(),
    );
  }
}
