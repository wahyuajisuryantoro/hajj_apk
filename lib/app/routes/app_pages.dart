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
import '../modules/dashboard_all_berita/bindings/dashboard_all_berita_binding.dart';
import '../modules/dashboard_all_berita/views/dashboard_all_berita_view.dart';
import '../modules/dashboard_all_program/bindings/dashboard_all_program_binding.dart';
import '../modules/dashboard_all_program/views/dashboard_all_program_view.dart';
import '../modules/dashboard_detail_berita/bindings/dashboard_detail_berita_binding.dart';
import '../modules/dashboard_detail_berita/views/dashboard_detail_berita_view.dart';
import '../modules/dashboard_detail_program/bindings/dashboard_detail_program_binding.dart';
import '../modules/dashboard_detail_program/views/dashboard_detail_program_view.dart';
import '../modules/faq/bindings/faq_binding.dart';
import '../modules/faq/views/faq_view.dart';
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
      transition: Transition.cupertino,
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
          transition: Transition.cupertino,
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.BERITA_DETAIL,
      page: () => const BeritaDetailView(),
      binding: BeritaDetailBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.BERITA_ALL,
      page: () => const BeritaAllView(),
      binding: BeritaAllBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.PROGRAM_DETAIL,
      page: () => const ProgramDetailView(),
      binding: ProgramDetailBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.PROGRAM_ALL,
      page: () => const ProgramAllView(),
      binding: ProgramAllBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MITRA,
      page: () => const MitraView(),
      binding: MitraBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.JAMAAH,
      page: () => const JamaahView(),
      binding: JamaahBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.CUSTOMER,
      page: () => const CustomerView(),
      binding: CustomerBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.AKUN,
      page: () => const AkunView(),
      binding: AkunBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MITRA_ADD,
      page: () => const MitraAddView(),
      binding: MitraAddBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.CUSTOMER_ADD,
      page: () => const CustomerAddView(),
      binding: CustomerAddBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.BONUS,
      page: () => const BonusView(),
      binding: BonusBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.AKUN_PROFILE_EDIT,
      page: () => const AkunProfileEditView(),
      binding: AkunProfileEditBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.AKUN_PASSWORD_EDIT,
      page: () => const AkunPasswordEditView(),
      binding: AkunPasswordEditBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.JAMAAH_LIST,
      page: () => const JamaahListView(),
      binding: JamaahListBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.SYARAT_KETENTUAN,
      page: () => const SyaratKetentuanView(),
      binding: SyaratKetentuanBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.KEBIJAKAN_PRIVASI,
      page: () => const KebijakanPrivasiView(),
      binding: KebijakanPrivasiBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.DASHBOARD_ALL_BERITA,
      page: () => const DashboardAllBeritaView(),
      binding: DashboardAllBeritaBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_DETAIL_BERITA,
      page: () => const DashboardDetailBeritaView(),
      binding: DashboardDetailBeritaBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.DASHBOARD_ALL_PROGRAM,
      page: () => const DashboardAllProgramView(),
      binding: DashboardAllProgramBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.DASHBOARD_DETAIL_PROGRAM,
      page: () => const DashboardDetailProgramView(),
      binding: DashboardDetailProgramBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.FAQ,
      page: () => const FaqView(),
      binding: FaqBinding(),
      transition: Transition.cupertino,
    ),
  ];
}
