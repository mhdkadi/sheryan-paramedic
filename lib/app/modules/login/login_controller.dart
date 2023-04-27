import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/core/repositories/user_repository.dart';

class LoginController extends GetxController {
  final UserRepository userRepository;

  LoginController({required this.userRepository});
  bool isloading = false;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      isloading = true;
      update();
      await userRepository.login(
        username: username,
        password: password,
      );
      isloading = false;
      update();
      Get.offAllNamed("/homePage");
    } catch (e) {
      isloading = false;
      update();
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
