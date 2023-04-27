import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/modules/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
