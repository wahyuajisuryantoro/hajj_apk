import 'package:get/get.dart';
import 'package:hajj/app/routes/app_pages.dart';

class BottomNavigationController extends GetxController {
  static BottomNavigationController get to => Get.find();

  final RxInt selectedIndex = 0.obs;

  // Mapping routes untuk setiap index
  final List<String> indexToRoute = [
    Routes.DASHBOARD,
    Routes.MITRA,
    Routes.CUSTOMER,
    Routes.BONUS,
    Routes.AKUN,
  ];

  // Mapping nama halaman untuk setiap index
  final List<String> pageNames = [
    'Dashboard',
    'Mitra',
    'Customer',
    'Bonus',
    'Akun'
  ];

  void changePage(int index, {bool useOffAll = true}) {
    selectedIndex.value = index;
    if (useOffAll) {
      Get.offAllNamed(indexToRoute[index]);
    } else {
      Get.toNamed(indexToRoute[index]);
    }
  }

  void navigateToRoute(String route) {
  int index = indexToRoute.indexOf(route);
  if (index != -1) {
    selectedIndex.value = index;
    Get.toNamed(route);
  }
}

  // Method untuk mendapatkan index dari route
  int getIndexFromRoute(String route) {
    return indexToRoute.indexOf(route);
  }

  // Method untuk mendapatkan nama halaman dari index
  String getPageName(int index) {
    return pageNames[index];
  }

  // Method untuk cek apakah route saat ini aktif
  bool isActiveRoute(String route) {
    return Get.currentRoute == route;
  }
}
