import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/modules/home/home_binding.dart';
import 'package:sheryan_paramedic/app/modules/home/home_view.dart';
import 'package:sheryan_paramedic/app/modules/login/login_binding.dart';
import 'package:sheryan_paramedic/app/modules/login/login_view.dart';
import 'package:sheryan_paramedic/app/modules/notifications/notificatoin_view.dart';
import 'package:sheryan_paramedic/app/modules/profile/paramedic_profile_binding.dart';
import 'package:sheryan_paramedic/app/modules/profile/paramedic_profile_view.dart';
import 'package:sheryan_paramedic/app/modules/register/register_binding.dart';
import 'package:sheryan_paramedic/app/modules/register/register_view.dart';
import 'package:sheryan_paramedic/app/modules/wrapper/wrapper_binding.dart';
import 'package:sheryan_paramedic/app/modules/wrapper/wrapper_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/wrapperPage",
      getPages: [
        GetPage(
          name: "/loginPage",
          page: () => LoginView(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: "/registerPage",
          page: () => RegisterView(),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: "/homePage",
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: "/ParamedicProfile",
          page: () => const ParamedicProfile(),
          binding: ParamedicProfileBinding(),
        ),
        GetPage(
          name: "/wrapperPage",
          page: () => const WrapperView(),
          binding: WrapperBinding(),
        ),
        GetPage(
          name: "/NotificatoinsView",
          page: () => const NotificatoinsView(),
        ),
      ],
    );
  }
}
