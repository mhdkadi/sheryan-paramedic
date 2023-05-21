// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sheryan_paramedic/app/core/helpers/data_helper.dart';
import 'package:sheryan_paramedic/app/core/theme/colors.dart';
import 'package:sheryan_paramedic/app/core/widgets/elevated_button.dart';
import 'package:sheryan_paramedic/app/core/widgets/input_fields.dart';

import '../../../core/widgets/widget_state.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  final form = FormGroup({
    "username": FormControl<String>(
      validators: [
        Validators.required,
        Validators.maxLength(40),
      ],
      value: DataHelper.user?.username,
    ),
    "fullName": FormControl<String>(
      validators: [
        Validators.required,
        Validators.maxLength(40),
      ],
      value: DataHelper.user?.fullName,
    ),
    "phone": FormControl<String>(
      validators: [
        Validators.required,
        Validators.maxLength(10),
        phone,
      ],
      value: DataHelper.user?.phone,
    )
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الملف الشخصي",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: StateBuilder<ProfileController>(
        id: "RegisterView",
        disableState: true,
        initialWidgetState: WidgetState.loaded,
        builder: (widgetState, controller) {
          return ReactiveForm(
            formGroup: form,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  HeaderTextField(
                    widgetState: widgetState,
                    formControlName: "fullName",
                    hintText: "أدخل الاسم الكامل",
                    header: "الاسم الكامل",
                    maxLength: 40,
                    keyboardType: TextInputType.name,
                    validationMessages: {
                      ValidationMessage.required: (_) => "أدخل الاسم الكامل",
                      ValidationMessage.maxLength: (_) =>
                          "الاسم الكامل طويل جداً",
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  HeaderTextField(
                    widgetState: widgetState,
                    formControlName: "phone",
                    hintText: "أدخل رقم الهاتف",
                    header: "رقم الهاتف",
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    validationMessages: {
                      ValidationMessage.required: (_) => "أدخل رقم الهاتف",
                      "phone": (_) => "رقم هاتف غير صالح",
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  HeaderTextField(
                    widgetState: widgetState,
                    formControlName: "username",
                    hintText: "أدخل اسم المستخدم",
                    header: "اسم المستخدم",
                    maxLength: 40,
                    keyboardType: TextInputType.name,
                    validationMessages: {
                      ValidationMessage.required: (_) => "أدخل اسم المستخدم",
                      ValidationMessage.maxLength: (_) =>
                          "اسم المستخدم طويل جداً",
                    },
                    textInputAction: TextInputAction.next,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
