import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/core/repositories/user_repository.dart';
import 'package:sheryan_paramedic/app/core/services/local_database.dart';
import 'package:sheryan_paramedic/app/modules/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Dio(BaseOptions(
        contentType: "application/json",
        baseUrl: "http://192.168.48.6:3000",
        connectTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5))));
    Get.put(
        UserRepository(dio: Get.find<Dio>(), localDataBase: LocalDataBase()));
    Get.put(LoginController(userRepository: Get.find<UserRepository>()));
  }
}
