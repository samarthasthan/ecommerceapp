// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/delete_account_controller.dart';
import 'package:ecommerceapp/controllers/nagivation_animations/up_down_navigation.dart';
import 'package:ecommerceapp/views/boarding/onboard_page.dart';
import 'package:ecommerceapp/views/widgets/buttons/basic_text_button.dart';
import 'package:ecommerceapp/views/widgets/texts/big_heading.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: padding * 2, left: padding * 1.5),
                    child: Row(
                      children: [
                        Paragraph(
                          text: 'Edit',
                          color: lightBlue,
                        ),
                        SizedBox(width: padding / 8),
                        Icon(
                          PhosphorIcons.regular.pencilSimple,
                          size: padding,
                          color: lightBlue,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Divider(),
            ),
            AccountPageItems(
              title: 'Orders',
              description: 'Find order updates, return & cancellations',
              icon: PhosphorIcons.regular.cube,
            ),
            AccountPageItems(
              title: 'Rate my orders',
              description: 'Help other shoppers',
              icon: PhosphorIcons.regular.star,
            ),
            AccountPageItems(
              title: 'Wishlist',
              description: 'Save & view your favourites here',
              icon: PhosphorIcons.regular.heart,
            ),
            AccountPageItems(
              title: 'Chat with us',
              description:
                  'Chat assistance for orders, refunds & cancellations',
              icon: PhosphorIcons.regular.chatCircle,
            ),
            AccountPageItems(
              title: 'Help Center',
              description: 'Raise a concern or read our FAQs',
              icon: PhosphorIcons.regular.info,
            ),
            AccountPageItems(
              title: 'Profile',
              description: 'Manage your profile information',
              icon: PhosphorIcons.regular.user,
            ),
            AccountPageItems(
              title: 'Addresses',
              description: 'Manage your addresses here',
              icon: PhosphorIcons.regular.houseLine,
            ),
            AccountPageItems(
              title: 'Payments methods',
              description: 'Manage your saved payments methods',
              icon: PhosphorIcons.regular.creditCard,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
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
      required this.description});

  IconData icon;
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: padding, vertical: padding / 1.3),
      child: Column(
        children: [
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
          const Divider()
        ],
      ),
    );
  }
}
