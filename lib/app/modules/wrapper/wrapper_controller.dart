import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/core/models/user_model.dart';
import 'package:sheryan_paramedic/app/core/services/local_database.dart';

class WrpperController extends GetxController {
  final LocalDataBase localDataBase;

  WrpperController(this.localDataBase);

  @override
  void onInit() async {
    User? user = await localDataBase.getUser();
    if (user == null) {
      Get.offAllNamed("/loginPage");
    } else {
      Get.offAllNamed("/homePage");
    }
    super.onInit();
  }
}
