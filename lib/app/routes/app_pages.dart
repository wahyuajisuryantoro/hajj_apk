import 'package:get/get.dart';

import '../modules/akun/bindings/akun_binding.dart';
import '../modules/akun/views/akun_view.dart';
import '../modules/akun_password_edit/bindings/akun_password_edit_binding.dart';
import '../modules/akun_password_edit/views/akun_password_edit_view.dart';
import '../modules/akun_profile_edit/bindings/akun_profile_edit_binding.dart';
import '../modules/akun_profile_edit/views/akun_profile_edit_view.dart';
import '../modules/berita-detail/bindings/berita_detail_binding.dart';
import '../modules/berita-detail/views/berita_detail_view.dart';
import '../modules/berita_all/bindings/berita_all_binding.dart';
import '../modules/berita_all/views/berita_all_view.dart';
import '../modules/bonus/bindings/bonus_binding.dart';
import '../modules/bonus/views/bonus_view.dart';
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
import '../modules/jamaah_list/bindings/jamaah_list_binding.dart';
import '../modules/jamaah_list/views/jamaah_list_view.dart';
import '../modules/kebijakan_privasi/bindings/kebijakan_privasi_binding.dart';
import '../modules/kebijakan_privasi/views/kebijakan_privasi_view.dart';
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
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/syarat_ketentuan/bindings/syarat_ketentuan_binding.dart';
import '../modules/syarat_ketentuan/views/syarat_ketentuan_view.dart';

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
    GetPage(
      name: _Paths.BONUS,
      page: () => const BonusView(),
      binding: BonusBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.AKUN_PROFILE_EDIT,
      page: () => const AkunProfileEditView(),
      binding: AkunProfileEditBinding(),
    ),
    GetPage(
      name: _Paths.AKUN_PASSWORD_EDIT,
      page: () => const AkunPasswordEditView(),
      binding: AkunPasswordEditBinding(),
    ),
    GetPage(
      name: _Paths.JAMAAH_LIST,
      page: () => const JamaahListView(),
      binding: JamaahListBinding(),
    ),
    GetPage(
      name: _Paths.SYARAT_KETENTUAN,
      page: () => const SyaratKetentuanView(),
      binding: SyaratKetentuanBinding(),
    ),
    GetPage(
      name: _Paths.KEBIJAKAN_PRIVASI,
      page: () => const KebijakanPrivasiView(),
      binding: KebijakanPrivasiBinding(),
    ),
  ];
}
