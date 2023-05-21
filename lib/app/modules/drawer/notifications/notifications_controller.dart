import 'package:sheryan_paramedic/app/core/helpers/data_helper.dart';
import 'package:sheryan_paramedic/app/core/models/notification_model.dart';
import 'package:sheryan_paramedic/app/core/repositories/constants_repository.dart';

import '../../../core/services/getx_state_controller.dart';
import '../../../core/services/request_mixin.dart';

class NotificationsController extends GetxStateController {
  final ConstantsRepository constantsRepository;
  NotificationsController({
    required this.constantsRepository,
  });
  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }

  List<NotificationModel> notifications = [];
  Future<void> getNotifications() async {
    await requestMethod(
      ids: ["NotificationsView"],
      requestType: RequestType.getData,
      function: () async {
        notifications = await constantsRepository.getNotifications(
            userId: DataHelper.user!.id);
        return notifications;
      },
    );
  }
}
