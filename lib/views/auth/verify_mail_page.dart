// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/utils.dart';
import 'package:ecommerceapp/controllers/verify_otp.dart';
import 'package:ecommerceapp/views/boarding/onboard_page.dart';
import 'package:ecommerceapp/views/widgets/buttons/basic_text_button.dart';
import 'package:ecommerceapp/views/widgets/textfields/form_textfield.dart';
import 'package:ecommerceapp/views/widgets/texts/big_heading.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VerifyMailPage extends StatelessWidget {
  VerifyMailPage({super.key});

  final RxBool isAnyTextFieldEmpty = false.obs;
  RxBool isVerifyLoading = false.obs;
  VerifyOTP verifyOTPController = Get.put(VerifyOTP());

  @override
  Widget build(BuildContext context) {
    isAnyTextFieldEmpty.value = _checkIfAnyTextFieldIsEmpty();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        appBar: AppBar(
            backgroundColor: whiteColor,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: blackColor,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  ClearTextFields().clearAll();
                  Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => StartPage(),
                    ),
                    (route) =>
                        false, //if you want to disable back feature set to false
                  );
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
              physics: NeverScrollableScrollPhysics(),
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
                          text: "Confirm your email",
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
                          text: "We sent a OTP to ${emailController.text}.",
                        ),
                        SizedBox(
                          width: padding / 4,
                        ),
                        Paragraph(
                          text: "Change",
                          color: lightBlue,
                          decoration: TextDecoration.underline,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: padding,
                    ),
                    FormTextField(
                      text: "Verification Code",
                      controller: verificationCodeController,
                      onChange: (_) => isAnyTextFieldEmpty.value =
                          _checkIfAnyTextFieldIsEmpty(),
                    ),
                    SizedBox(
                      height: padding,
                    ),
                    Paragraph(
                      weight: FontWeight.normal,
                      color: blackColor,
                      text:
                          "Did'nt get the email? Check your spam/junk or resend it.",
                    ),
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: isKeyboardVisible ? 28.0 : 13.0,
                        end: isKeyboardVisible ? 13.0 : 28.0,
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
                            isVerifyLoading.value = true;
                            bool verifySuccess =
                                await verifyOTPController.verify(
                              email: emailController.text,
                              otp: verificationCodeController.text,
                            );
                            isVerifyLoading.value = false;

                            if (verifySuccess) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      StartPage(),
                                ),
                                (route) =>
                                    false, //if you want to disable back feature set to false
                              );
                              ClearTextFields().clearAll();
                            }
                          },
                          child: isVerifyLoading.value == false
                              ? BasicTextButton(
                                  text: "Verify",
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
    isVerifyLoading.value = false;
    return verificationCodeController.text.isEmpty;
  }
}
