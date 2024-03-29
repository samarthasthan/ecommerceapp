import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/user_controllers/verify_otp.dart';
import 'package:ecommerceapp/controllers/utils.dart';
import 'package:ecommerceapp/views/boarding_pages/onboard_page.dart';
import 'package:ecommerceapp/views/widgets/buttons/basic_text_button.dart';
import 'package:ecommerceapp/views/widgets/textfields/form_textfield.dart';
import 'package:ecommerceapp/views/widgets/texts/big_heading.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
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
                Get.delete<VerifyOTP>;
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
                          color: redColor,
                          decoration: TextDecoration.underline,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: padding,
                    ),
                    FormTextField(
                      text: "Verification Code",
                      capitalization: TextCapitalization.none,
                      keyBoardType: TextInputType.number,
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
                    SizedBox(
                      height: padding,
                    ),
                    Obx(
                      () => GestureDetector(
                          onTap: () async {
                            isVerifyLoading.value = true;
                            FocusManager.instance.primaryFocus?.unfocus();
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
                          child: BasicTextButton(
                            text: "Verify",
                            backgroundColor: isAnyTextFieldEmpty.value
                                ? greyColor
                                : blackColor,
                            textColor: whiteColor,
                            isLoading: isVerifyLoading,
                            height: bigButtonHeight,
                          )),
                    ),
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
