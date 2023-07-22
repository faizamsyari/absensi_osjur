import 'package:get/get.dart';

import '../modules/add_account/bindings/add_account_binding.dart';
import '../modules/add_account/views/add_account_view.dart';
import '../modules/all_data/bindings/all_data_binding.dart';
import '../modules/all_data/views/all_data_view.dart';
import '../modules/blank_pagee/bindings/blank_pagee_binding.dart';
import '../modules/blank_pagee/views/blank_pagee_view.dart';
import '../modules/bottom_nav/bindings/bottom_nav_binding.dart';
import '../modules/bottom_nav/views/bottom_nav_view.dart';
import '../modules/chart/bindings/chart_binding.dart';
import '../modules/chart/views/chart_view.dart';
import '../modules/chooseperizinan/bindings/chooseperizinan_binding.dart';
import '../modules/chooseperizinan/views/chooseperizinan_view.dart';
import '../modules/client/bindings/client_binding.dart';
import '../modules/client/views/client_view.dart';
import '../modules/detail_admin/bindings/detail_admin_binding.dart';
import '../modules/detail_admin/views/detail_admin_view.dart';
import '../modules/edit_data/bindings/edit_data_binding.dart';
import '../modules/edit_data/views/edit_data_view.dart';
import '../modules/halaman_utama/bindings/halaman_utama_binding.dart';
import '../modules/halaman_utama/views/halaman_utama_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/perizinan/bindings/perizinan_binding.dart';
import '../modules/perizinan/views/perizinan_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/read_presence/bindings/read_presence_binding.dart';
import '../modules/read_presence/views/read_presence_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CLIENT,
      page: () => const ClientView(),
      binding: ClientBinding(),
    ),
    GetPage(
      name: _Paths.BLANK_PAGEE,
      page: () => const BlankPageeView(),
      binding: BlankPageeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ACCOUNT,
      page: () => const AddAccountView(),
      binding: AddAccountBinding(),
    ),
    GetPage(
      name: _Paths.ALL_DATA,
      page: () => const AllDataView(),
      binding: AllDataBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ADMIN,
      page: () => const DetailAdminView(),
      binding: DetailAdminBinding(),
    ),
    GetPage(
      name: _Paths.READ_PRESENCE,
      page: () => const ReadPresenceView(),
      binding: ReadPresenceBinding(),
    ),
    GetPage(
      name: _Paths.HALAMAN_UTAMA,
      page: () => HalamanUtamaView(),
      binding: HalamanUtamaBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAV,
      page: () => const BottomNavView(),
      binding: BottomNavBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PERIZINAN,
      page: () => const PerizinanView(),
      binding: PerizinanBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSEPERIZINAN,
      page: () => const ChooseperizinanView(),
      binding: ChooseperizinanBinding(),
    ),
    GetPage(
      name: _Paths.CHART,
      page: () => const ChartView(),
      binding: ChartBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_DATA,
      page: () => const EditDataView(),
      binding: EditDataBinding(),
    ),
  ];
}
