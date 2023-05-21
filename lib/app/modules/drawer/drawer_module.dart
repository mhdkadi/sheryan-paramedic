import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/core/services/secure_get_page.dart';
import 'package:sheryan_paramedic/app/modules/drawer/notifications/notifications_binding.dart';
import 'package:sheryan_paramedic/app/modules/drawer/notifications/notifications_view.dart';
import 'package:sheryan_paramedic/app/modules/drawer/profile/profile_binding.dart';
import 'package:sheryan_paramedic/app/modules/drawer/profile/profile_view.dart';
import 'package:sheryan_paramedic/app/modules/drawer/shared/constant/drawer_routes.dart';

part 'shared/drawer_pages.dart';

class DrawerModule {
  static List<GetPage> get drawerPages => _DrawerPages.drawerPages;
}
