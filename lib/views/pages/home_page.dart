// ignore_for_file: must_be_immutable

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/dynamic_page_contoller.dart';
// ignore: unused_import
import 'package:ecommerceapp/controllers/main_menu_controller.dart';
import 'package:ecommerceapp/controllers/nagivation_animations/up_down_navigation.dart';

import 'package:ecommerceapp/views/pages/cart_page.dart';
import 'package:ecommerceapp/views/widgets/dynamic_page/dynamic_page_widgets.dart';
import 'package:ecommerceapp/views/widgets/texts/big_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final DynamicPageController homePageController =
      Get.put(DynamicPageController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          centerTitle: false,
          title: BigHeading(
            text: "FruBay",
            color: blackColor,
            weight: FontWeight.w900,
          ),
          actions: [
            PhosphorIcon(
              PhosphorIcons.light.magnifyingGlass,
              color: blackColor,
            ),
            SizedBox(
              width: padding,
            ),
            GestureDetector(
              child: PhosphorIcon(
                PhosphorIcons.light.shoppingCartSimple,
                color: blackColor,
              ),
              onTap: () {
                UpDownNavigation().navigateToPage(context, page: CartPage());
              },
            ),
            SizedBox(
              width: padding,
            )
          ],
          elevation: 1,
          // toolbarHeight: 40,
        ),
        body: FutureBuilder(
            future: homePageController.getDynamicPage(homePageTitle),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while waiting for data
                return const Center(child: CupertinoActivityIndicator());
              } else if (snapshot.hasError) {
                // Display an error message if an error occurred
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // Display the data once it's available
                return DynamicPageList(
                    data: snapshot.data!); // Replace with your widget
              } else {
                // Default fallback, you can customize this case
                return const Text('No data available.');
              }
            }));
  }

  @override
  bool get wantKeepAlive => true;
}
