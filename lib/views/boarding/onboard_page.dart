import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/nagivation_animations/up_down_navigation.dart';
import 'package:ecommerceapp/controllers/onboard_controller.dart';
import 'package:ecommerceapp/views/auth/login_page.dart';
import 'package:ecommerceapp/views/auth/sign_up_page.dart';
import 'package:ecommerceapp/views/widgets/buttons/basic_text_button.dart';
import 'package:ecommerceapp/views/widgets/textfields/form_textfield.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StartPage extends StatelessWidget {
  StartPage({super.key});

  final onBoardController = Get.put(OnBoardConller());

  void _showPolicyPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "API Base Url",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
                SizedBox(height: padding),
                FormTextField(
                  controller: baseUrlController,
                  onChange: (value) {
                    baseUrl = value;
                  },
                ),
                SizedBox(height: padding),
                GestureDetector(
                  child: BasicTextButton(
                    text: "Save",
                    backgroundColor: blackColor,
                    textColor: whiteColor,
                  ),
                  onTap: () {
                    print(baseUrl);
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    onBoardController
        .startBackgroundColorChange(); // Start the color change timer
    return Obx(() => Scaffold(
          backgroundColor: onBoardController.backGroundColor.value,
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: onBoardController.backGroundColor.value,
            elevation: 0,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  height: 625.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: 70.h,
                        child: Center(
                          child: AutoSizeText(
                            onBoardController.qoute.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                                color: blackColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: padding * 1.5,
                      ),
                      SizedBox(
                        width: 250.w,
                        height: 250.h,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(200),
                              topRight: Radius.circular(200)),
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: onBoardController.imageUrl.value),
                        ),
                      ),
                      SizedBox(
                        height: padding,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          _showPolicyPopup(context);
                        },
                        child: Paragraph(
                          weight: FontWeight.bold,
                          color: blackColor,
                          text:
                              "By proceeding, I Accept the term for FruBay Services\nand confirm that i have read FruBay's Privacy Policy.",
                        ),
                      ),
                      SizedBox(
                        height: padding,
                      ),
                      GestureDetector(
                        onTap: () {
                          UpDownNavigation()
                              .navigateToPage(context, page: SignUpPage());
                        },
                        child: BasicTextButton(
                          text: "Create Account",
                          backgroundColor: blackColor,
                          textColor: whiteColor,
                        ),
                      ),
                      SizedBox(
                        height: padding,
                      ),
                      GestureDetector(
                        onTap: () {
                          UpDownNavigation()
                              .navigateToPage(context, page: LoginPage());
                        },
                        child: BasicTextButton(
                          text: "Sign In",
                          backgroundColor: whiteColor,
                          textColor: blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
