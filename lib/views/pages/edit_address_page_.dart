// ignore_for_file: must_be_immutable

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/nagivation_animations/up_down_navigation.dart';
import 'package:ecommerceapp/controllers/sign_up_controller.dart';
import 'package:ecommerceapp/controllers/utils.dart';
import 'package:ecommerceapp/views/auth/verify_mail_page.dart';
import 'package:ecommerceapp/views/widgets/buttons/basic_text_button.dart';
import 'package:ecommerceapp/views/widgets/textfields/form_textfield.dart';
import 'package:ecommerceapp/views/widgets/texts/big_heading.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditAddressPage extends StatelessWidget {
  EditAddressPage({super.key});

  RxBool isAnyTextFieldEmpty = false.obs;
  RxBool isLoading = false.obs;
  SignUpController signUpController = Get.put(SignUpController());
  String gender = '';

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
                          text: "Edit address",
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
                          text: "Want new address?",
                        ),
                        SizedBox(
                          width: padding / 4,
                        ),
                        Paragraph(
                          text: "Create now",
                          color: lightBlue,
                          decoration: TextDecoration.underline,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: padding,
                    ),
                    Row(
                      children: [
                        FormTextField(
                          text: 'First Name',
                        ),
                        SizedBox(
                          width: padding,
                        ),
                        FormTextField(
                          text: 'Last Name',
                        ),
                      ],
                    ),
                    FormTextField(
                      text: 'Phone number',
                    ),
                    Row(
                      children: [
                        FormTextField(
                          text: 'Pincode',
                        ),
                        SizedBox(
                          width: padding,
                        ),
                        FormTextField(
                          text: 'State',
                        ),
                      ],
                    ),
                    FormTextField(
                      text: 'Address (House No, Building, Street, Area)',
                    ),
                    FormTextField(
                      text: 'Locality/ Town',
                    ),
                    FormTextField(
                      text: 'City/ District',
                    ),
                    Row(
                      children: [
                        Radio(
                          value: "male",
                          groupValue: gender,
                          onChanged: (value) {},
                        ),
                        Paragraph(
                          text: 'Home',
                        ),
                        Radio(
                          value: "female",
                          groupValue: gender,
                          onChanged: (value) {},
                        ),
                        Paragraph(
                          text: 'Office',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (value) {}),
                        Paragraph(
                          text: 'Mark this as deault address',
                        ),
                      ],
                    ),
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: isKeyboardVisible ? 8.70 : 1.5,
                        end: isKeyboardVisible ? 1.5 : 8.70,
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
                            bool signUpSuccess = await signUpController.signUp(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              phoneNo: int.parse(phoneNumberController.text),
                              password: passwordController.text,
                            );
                            isLoading.value = false;

                            if (signUpSuccess) {
                              // ignore: use_build_context_synchronously
                              UpDownNavigation().navigateToPage(context,
                                  page: VerifyMailPage());
                            }
                          },
                          child: isLoading.value == false
                              ? BasicTextButton(
                                  text: "Confirm and continue",
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
    return firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        passwordController.text.isEmpty;
  }
}
