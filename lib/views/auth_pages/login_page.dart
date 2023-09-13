// ignore_for_file: must_be_immutable

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/user_controllers/login_controller.dart';
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
                          color: redColor,
                          decoration: TextDecoration.underline,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: padding,
                    ),
                    FormTextField(
                      text: "Email",
                      keyBoardType: TextInputType.emailAddress,
                      capitalization: TextCapitalization.none,
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
                      capitalization: TextCapitalization.none,
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
                          color: redColor,
                          text: "Forgot it",
                          decoration: TextDecoration.underline,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: padding,
                    ),
                    Obx(
                      () => GestureDetector(
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
                          child: BasicTextButton(
                            text: "Log In",
                            backgroundColor: isAnyTextFieldEmpty.value
                                ? greyColor
                                : blackColor,
                            textColor: whiteColor,
                            isLoading: isLoading,
                            height: bigButtonHeight,
                          )),
                    )
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
