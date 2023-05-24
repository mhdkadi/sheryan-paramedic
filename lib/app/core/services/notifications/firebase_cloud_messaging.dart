import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:local_database/config/logger.dart';
import 'package:sheryan_paramedic/app/core/constants/globals.dart';
import 'package:sheryan_paramedic/app/core/models/order_model.dart';
import 'package:sheryan_paramedic/app/core/theme/colors.dart';
import 'package:sheryan_paramedic/app/modules/home/main_home/home_controller.dart';

part 'channels.dart';

AwesomeNotifications awesomeNotifications = AwesomeNotifications();

class NotificationService {
  NotificationService._internal();
  static NotificationService instance = NotificationService._internal();
  Future<String> getFcmToken() async {
    try {
      return await FirebaseMessaging.instance.getToken() ?? "unknown";
    } catch (_) {
      return "unknown";
    }
  }

  Future<void> deleteToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (_) {}
  }

  Future<bool> isSupported() async {
    return await FirebaseMessaging.instance.isSupported();
  }

  Future<void> initializeNotifications() async {
    try {
      await Firebase.initializeApp();
      await FirebaseMessaging.instance.requestPermission();
      await initializeAwesomeNotifications();
      await _onMessage();
    } catch (e) {
      logger(e.toString());
    }
  }

  Future<void> initializeAwesomeNotifications() async {
    logger("initializeAwesomeNotifications");
    await awesomeNotifications.initialize(
      null,
      channels,
      channelGroups: groups,
      debug: appMode != AppMode.release,
    );
    final bool result = await awesomeNotifications
        .requestPermissionToSendNotifications(permissions: [
      NotificationPermission.FullScreenIntent,
      NotificationPermission.CriticalAlert,
      NotificationPermission.Alert,
      NotificationPermission.Sound,
      NotificationPermission.Badge,
      NotificationPermission.Vibration,
      NotificationPermission.Light,
    ]);
    logger(result.toString(), name: "requestPermissionToSendNotifications");
  }

  Future<void> cancelNotifcation(int id) async {
    await awesomeNotifications.cancel(id);
  }

  Future<void> _onMessage() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        try {
          logger(message.toMap().toString());
          if (Get.isRegistered<MainHomeController>()) {
            Order order = Order.fromMap(jsonDecode((message.data["order"])));
            MainHomeController mainHomeController =
                Get.find<MainHomeController>();
            mainHomeController.newOrder(order);
          }
        } catch (e) {
          logger(e.toString());
        }
      },
    );
  }
}
