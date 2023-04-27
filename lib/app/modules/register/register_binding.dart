import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/core/repositories/user_repository.dart';
import 'package:sheryan_paramedic/app/modules/register/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController(userRepository: Get.find<UserRepository>()));
  }
}
