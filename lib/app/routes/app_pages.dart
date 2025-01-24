import 'package:get/get.dart';

import '../modules/akun/bindings/akun_binding.dart';
import '../modules/akun/views/akun_view.dart';
import '../modules/berita-detail/bindings/berita_detail_binding.dart';
import '../modules/berita-detail/views/berita_detail_view.dart';
import '../modules/berita_all/bindings/berita_all_binding.dart';
import '../modules/berita_all/views/berita_all_view.dart';
import '../modules/customer/bindings/customer_binding.dart';
import '../modules/customer/views/customer_view.dart';
import '../modules/customer_add/bindings/customer_add_binding.dart';
import '../modules/customer_add/views/customer_add_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/jamaah/bindings/jamaah_binding.dart';
import '../modules/jamaah/views/jamaah_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mitra/bindings/mitra_binding.dart';
import '../modules/mitra/views/mitra_view.dart';
import '../modules/mitra_add/bindings/mitra_add_binding.dart';
import '../modules/mitra_add/views/mitra_add_view.dart';
import '../modules/program-all/bindings/program_all_binding.dart';
import '../modules/program-all/views/program_all_view.dart';
import '../modules/program-detail/bindings/program_detail_binding.dart';
import '../modules/program-detail/views/program_detail_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.BERITA_DETAIL,
      page: () => const BeritaDetailView(),
      binding: BeritaDetailBinding(),
    ),
    GetPage(
      name: _Paths.BERITA_ALL,
      page: () => const BeritaAllView(),
      binding: BeritaAllBinding(),
    ),
    GetPage(
      name: _Paths.PROGRAM_DETAIL,
      page: () => const ProgramDetailView(),
      binding: ProgramDetailBinding(),
    ),
    GetPage(
      name: _Paths.PROGRAM_ALL,
      page: () => const ProgramAllView(),
      binding: ProgramAllBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.MITRA,
      page: () => const MitraView(),
      binding: MitraBinding(),
    ),
    GetPage(
      name: _Paths.JAMAAH,
      page: () => const JamaahView(),
      binding: JamaahBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER,
      page: () => const CustomerView(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: _Paths.AKUN,
      page: () => const AkunView(),
      binding: AkunBinding(),
    ),
    GetPage(
      name: _Paths.MITRA_ADD,
      page: () => const MitraAddView(),
      binding: MitraAddBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_ADD,
      page: () => const CustomerAddView(),
      binding: CustomerAddBinding(),
    ),
  ];
}
