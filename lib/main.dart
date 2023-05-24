import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_database/config/main_service.dart';
import 'package:sheryan_paramedic/app/modules/auth/auth_module.dart';

import 'app/core/constants/globals.dart';
import 'app/core/theme/colors.dart';
import 'app/core/theme/theme.dart';
import 'app/core/utils/logger.dart';
import 'app/core/widgets/app_messenger.dart';
import 'app_initial_binding.dart';
import 'app_pages.dart';

part 'app_initialize.dart';

void main() async {
  await _preInitializations();
  runApp(const MainWidget());
}

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      textDirection: TextDirection.rtl,
      scaffoldMessengerKey: snackbarKey,
      initialRoute: AuthModule.authInitialRoute,
      getPages: AppPages.appRoutes,
      initialBinding: AppInitialBindings(),
      debugShowCheckedModeBanner: appMode != AppMode.release,
      enableLog: appMode != AppMode.release,
      theme: CustomTheme.lightTheme(context),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}
