import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/modules/location/location_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationController());
  }
}
