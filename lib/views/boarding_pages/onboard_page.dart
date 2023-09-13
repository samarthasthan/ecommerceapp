import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/nagivation_animations/up_down_navigation.dart';
import 'package:ecommerceapp/views/auth_pages/login_page.dart';
import 'package:ecommerceapp/views/auth_pages/sign_up_page.dart';
import 'package:ecommerceapp/views/widgets/buttons/basic_text_button.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: whiteColor,
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
                        'Find the hottest\ndeal.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: primaryBoldFont,
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
                          imageUrl:
                              "https://assets.vogue.in/photos/5d288836e2f0130008fa5d30/1:1/w_1080,h_1080,c_limit/model%20nidhi%20sunil.jpg"),
                    ),
                  ),
                  SizedBox(
                    height: padding,
                  ),
                  const Spacer(),
                  Paragraph(
                    weight: FontWeight.normal,
                    color: blackColor,
                    align: TextAlign.center,
                    text:
                        "By proceeding, I Accept the term for FruBay Services\nand confirm that i have read FruBay's Privacy Policy.",
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
                      isLoading: tempBool,
                      height: bigButtonHeight,
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
                      backgroundColor: blackColor,
                      textColor: whiteColor,
                      isLoading: tempBool,
                      height: bigButtonHeight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
