import 'package:get/get.dart';

import 'package:chatapp/app/modules/change_profile/bindings/change_profile_binding.dart';
import 'package:chatapp/app/modules/change_profile/views/change_profile_view.dart';
import 'package:chatapp/app/modules/chat_room/bindings/chat_room_binding.dart';
import 'package:chatapp/app/modules/chat_room/views/chat_room_view.dart';
import 'package:chatapp/app/modules/home/bindings/home_binding.dart';
import 'package:chatapp/app/modules/home/views/home_view.dart';
import 'package:chatapp/app/modules/introduction/bindings/introduction_binding.dart';
import 'package:chatapp/app/modules/introduction/views/introduction_view.dart';
import 'package:chatapp/app/modules/login/bindings/login_binding.dart';
import 'package:chatapp/app/modules/login/views/login_view.dart';
import 'package:chatapp/app/modules/profile/bindings/profile_binding.dart';
import 'package:chatapp/app/modules/profile/views/profile_view.dart';
import 'package:chatapp/app/modules/search/bindings/search_binding.dart';
import 'package:chatapp/app/modules/search/views/search_view.dart';
import 'package:chatapp/app/modules/update_status/bindings/update_status_binding.dart';
import 'package:chatapp/app/modules/update_status/views/update_status_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_ROOM,
      page: () => ChatRoomView(),
      binding: ChatRoomBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_STATUS,
      page: () => UpdateStatusView(),
      binding: UpdateStatusBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PROFILE,
      page: () => ChangeProfileView(),
      binding: ChangeProfileBinding(),
    ),
  ];
}
