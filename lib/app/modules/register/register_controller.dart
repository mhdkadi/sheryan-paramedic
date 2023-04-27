import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/core/repositories/user_repository.dart';

class RegisterController extends GetxController {
  final UserRepository userRepository;

  RegisterController({required this.userRepository});
  bool isloding = false;
  Future<void> register({
    required String username,
    required String password,
    required String address,
    required String phoneNumber,
    required String hospital,
  }) async {
    try {
      isloding = true;
      update();
      await userRepository.register(
        username: username,
        password: password,
        address: address,
        phoneNumber: phoneNumber,
        hospital: hospital,
      );
      isloding = false;
      update();
      Get.offAllNamed("/homePage");
    } catch (e) {
      isloding = false;
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
