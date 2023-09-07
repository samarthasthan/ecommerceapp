// ignore_for_file: must_be_immutable

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/login_controller.dart';
import 'package:ecommerceapp/controllers/utils.dart';
import 'package:ecommerceapp/main_menu.dart';
import 'package:ecommerceapp/views/widgets/buttons/basic_text_button.dart';
import 'package:ecommerceapp/views/widgets/textfields/form_textfield.dart';
import 'package:ecommerceapp/views/widgets/texts/big_heading.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  RxBool isAnyTextFieldEmpty = false.obs;
  RxBool isLoading = false.obs;
  LoginController logInController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    isAnyTextFieldEmpty.value = firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        passwordController.text.isEmpty;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        appBar: AppBar(backgroundColor: whiteColor, elevation: 0, actions: [
          GestureDetector(
            onTap: () {
              Get.delete<LoginController>;
              Navigator.pop(context);
              ClearTextFields().clearAll();
            },
            child: const Icon(
              Icons.close,
              color: blackColor,
            ),
          ),
          SizedBox(
            width: padding,
          )
        ]),
        body: KeyboardVisibilityBuilder(
            builder: (BuildContext context, bool isKeyboardVisible) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                width: double.infinity,
                height: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !isKeyboardVisible ? const SizedBox() : const SizedBox(),
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: isKeyboardVisible ? 25.sp : 17.sp,
                        end: isKeyboardVisible ? 17.sp : 25.sp,
                      ),
                      duration: const Duration(milliseconds: 200),
                      curve: Curves
                          .easeInOutQuad, // Use the easing curve of your choice
                      builder:
                          (BuildContext context, double value, Widget? child) {
                        return BigHeading(
                          size: value,
                          text: "Log In",
                          weight: FontWeight.bold,
                        );
                      },
                    ),
                    SizedBox(
                      height: !isKeyboardVisible ? padding : padding / 4,
                    ),
                    Row(
                      children: [
                        Paragraph(
                          text: "Don't have account?",
                        ),
                        SizedBox(
                          width: padding / 4,
                        ),
                        Paragraph(
                          text: "Create Now",
                          color: lightBlue,
                          decoration: TextDecoration.underline,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: padding,
                    ),
                    FormTextField(
                      text: "Email",
                      controller: emailController,
                      onChange: (value) => isAnyTextFieldEmpty.value =
                          _checkIfAnyTextFieldIsEmpty(),
                    ),
                    SizedBox(
                      height: padding,
                    ),
                    FormTextField(
                      text: "Password",
                      controller: passwordController,
                      isSecret: true,
                      onChange: (value) => isAnyTextFieldEmpty.value =
                          _checkIfAnyTextFieldIsEmpty(),
                    ),
                    SizedBox(
                      height: padding,
                    ),
                    Row(
                      children: [
                        Paragraph(
                          color: blackColor,
                          text: "Forgot password?",
                        ),
                        SizedBox(
                          width: padding / 4,
                        ),
                        Paragraph(
                          color: lightBlue,
                          text: "Forgot it",
                          decoration: TextDecoration.underline,
                        ),
                      ],
                    ),
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: isKeyboardVisible ? 24.70 : 9.1,
                        end: isKeyboardVisible ? 9.1 : 24.70,
                      ),
                      duration: const Duration(milliseconds: 200),
                      curve: Curves
                          .easeInOutQuad, // Use the easing curve of your choice
                      builder:
                          (BuildContext context, double value, Widget? child) {
                        return SizedBox(
                          height: padding * value,
                        );
                      },
                    ),
                    Obx(
                      () => Transform.translate(
                        offset: Offset(
                            0,
                            isKeyboardVisible
                                ? 0
                                : 40), // Adjust the value as needed
                        child: GestureDetector(
                          onTap: () async {
                            isLoading.value = true;
                            FocusManager.instance.primaryFocus?.unfocus();
                            bool logInSuccess = await logInController.login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            isLoading.value = false;

                            if (logInSuccess) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return const MainMenu();
                              }), (r) {
                                return false;
                              });
                            }
                          },
                          child: isLoading.value == false
                              ? BasicTextButton(
                                  text: "Log In",
                                  backgroundColor: isAnyTextFieldEmpty.value
                                      ? greyColor
                                      : blackColor,
                                  textColor: whiteColor,
                                )
                              : Container(
                                  width: double.infinity,
                                  height: padding * 3,
                                  decoration: BoxDecoration(
                                      color: blackColor,
                                      borderRadius:
                                          BorderRadius.circular(padding / 2)),
                                  child: Center(
                                      child: SizedBox(
                                    height: padding * 1.5,
                                    width: padding * 1.5,
                                    child: const CircularProgressIndicator(
                                      color: whiteColor,
                                    ),
                                  ))),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom))
                  ],
                ),
              ),
            ),
          );
        }));
  }

  bool _checkIfAnyTextFieldIsEmpty() {
    return emailController.text.isEmpty || passwordController.text.isEmpty;
  }
}
