import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/modules/profile/paramedic_profile_controller.dart';

class ParamedicProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ParamedicProfileController());
  }
}
