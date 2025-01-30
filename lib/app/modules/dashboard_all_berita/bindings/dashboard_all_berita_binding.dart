import 'package:get/get.dart';

import '../controllers/dashboard_all_berita_controller.dart';

class DashboardAllBeritaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardAllBeritaController>(
      () => DashboardAllBeritaController(),
    );
  }
}
