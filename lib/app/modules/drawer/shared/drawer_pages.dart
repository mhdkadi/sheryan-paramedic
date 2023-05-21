part of '../drawer_module.dart';

class _DrawerPages {
  _DrawerPages._();

  static List<GetPage> drawerPages = [
    SecureGetPage(
      name: DrawerRoutes.profileRoute,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    SecureGetPage(
      name: DrawerRoutes.notificationsRoute,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
