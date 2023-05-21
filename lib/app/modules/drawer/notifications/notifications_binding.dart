import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/core/repositories/constants_repository.dart';

import 'notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      NotificationsController(
          constantsRepository: Get.find<ConstantsRepository>()),
    );
  }
}
