import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/core/services/local_database.dart';
import 'package:sheryan_paramedic/app/modules/wrapper/wrapper_controller.dart';

class WrapperBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WrpperController(LocalDataBase()));
  }
}
