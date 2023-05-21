import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/modules/auth/auth_module.dart';
import 'package:sheryan_paramedic/app/modules/drawer/drawer_module.dart';
import 'package:sheryan_paramedic/app/modules/home/home_module.dart';

class AppPages {
  AppPages._();
  static final List<GetPage<dynamic>> appRoutes = [
    ...AuthModule.authPages,
    ...HomeModule.homePages,
    ...DrawerModule.drawerPages,
  ];
}
