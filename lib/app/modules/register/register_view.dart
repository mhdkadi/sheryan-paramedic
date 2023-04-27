import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/modules/register/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phonNumberController = TextEditingController();
  final TextEditingController hospitalController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text("إنشاء حساب"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            const SizedBox(height: 30),
            Image.asset(
              "assets/images/ambulance.png",
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "الاسم",
                  style: TextStyle(fontSize: 20),
                ),
                hintText: "أدخل الاسم",
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: phonNumberController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "رقم الهاتف",
                  style: TextStyle(fontSize: 20),
                ),
                hintText: "أدخل رقم الهاتف ",
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "العنوان",
                  style: TextStyle(fontSize: 20),
                ),
                hintText: "أدخل العنوان",
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: hospitalController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "المشفى",
                  style: TextStyle(fontSize: 20),
                ),
                hintText: "أدخل المشفى",
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "كلمة المرور",
                  style: TextStyle(fontSize: 20),
                ),
                hintText: "أدخل كلمة المرور",
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: SizedBox(
                width: 150,
                height: 50,
                child: GetBuilder<RegisterController>(builder: (Controller) {
                  return ElevatedButton(
                    onPressed: Controller.isloding
                        ? null
                        : () {
                            controller.register(
                              address: addressController.text,
                              hospital: hospitalController.text,
                              password: passwordController.text,
                              phoneNumber: phonNumberController.text,
                              username: userNameController.text,
                            );
                          },
                    child: controller.isloding
                        ? const CircularProgressIndicator()
                        : const Text(
                            "أنشأ حساب",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
