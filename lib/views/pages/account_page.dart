// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/delete_account_controller.dart';
import 'package:ecommerceapp/controllers/nagivation_animations/up_down_navigation.dart';
import 'package:ecommerceapp/views/boarding/onboard_page.dart';
import 'package:ecommerceapp/views/pages/address_page.dart';
import 'package:ecommerceapp/views/widgets/buttons/basic_text_button.dart';
import 'package:ecommerceapp/views/widgets/texts/big_heading.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: whiteColor,
        elevation: 1,
        title: Paragraph(
          text: "My Account",
          color: blackColor,
          weight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2000.sp),
                    child: CachedNetworkImage(
                      imageUrl: 'https://placehold.co/200x200/png?text=SA',
                      height: 70.h,
                    ),
                  ),
                  SizedBox(
                    width: padding,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigHeading(
                        text: 'Samarth Asthan',
                        weight: FontWeight.bold,
                        size: padding,
                      ),
                      Paragraph(
                        text: 'samarthasthan27@gmail.com',
                      ),
                      Paragraph(
                        text: '+91 9557037766',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: const Divider(),
            ),
            AccountPageItems(
              title: 'Orders',
              description: 'Find order updates, return & cancellations',
              icon: PhosphorIcons.light.cube,
              page: const AddressPage(),
            ),
            AccountPageItems(
              title: 'Rate my orders',
              description: 'Help other shoppers',
              icon: PhosphorIcons.light.star,
              page: const AddressPage(),
            ),
            AccountPageItems(
              title: 'Chat with us',
              description:
                  'Chat assistance for orders, refunds & cancellations',
              icon: PhosphorIcons.light.chatCircle,
              page: const AddressPage(),
            ),
            AccountPageItems(
              title: 'Help Center',
              description: 'Raise a concern or read our FAQs',
              icon: PhosphorIcons.light.info,
              page: const AddressPage(),
            ),
            AccountPageItems(
              title: 'Addresses',
              description: 'Manage your addresses here',
              icon: PhosphorIcons.light.houseLine,
              page: const AddressPage(),
            ),
            AccountPageItems(
              title: 'Payments methods',
              description: 'Manage your saved payments methods',
              icon: PhosphorIcons.light.creditCard,
              page: const AddressPage(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding / 2),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      APICacheManager().deleteCache('login_token');
                      UpDownNavigation()
                          .navigateToPage(context, page: StartPage());
                    },
                    child: BasicTextButton(
                      text: "Log out",
                      textColor: whiteColor,
                      backgroundColor: blackColor,
                    ),
                  ),
                  SizedBox(
                    height: padding,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await DeleteAccount().delete();
                      Get.delete<DeleteAccount>;
                      UpDownNavigation()
                          .navigateToPage(context, page: StartPage());
                    },
                    child: BasicTextButton(
                      text: "Delete Account",
                      textColor: whiteColor,
                      backgroundColor: blackColor,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: padding,
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AccountPageItems extends StatelessWidget {
  AccountPageItems(
      {super.key,
      required this.icon,
      required this.title,
      required this.description,
      required this.page});

  IconData icon;
  String title;
  String description;
  Widget page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => page);
      },
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            children: [
              SizedBox(
                height: padding / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Paragraph(
                        text: title,
                        weight: FontWeight.bold,
                      ),
                      Paragraph(
                        text: description,
                      ),
                    ],
                  ),
                  Icon(
                    icon,
                  ),
                ],
              ),
              SizedBox(
                height: padding / 2,
              ),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
