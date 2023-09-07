// ignore_for_file: must_be_immutable

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/dynamic_page_contoller.dart';
// ignore: unused_import
import 'package:ecommerceapp/controllers/main_menu_controller.dart';
import 'package:ecommerceapp/views/widgets/dynamic_page/dynamic_page_widgets.dart';
import 'package:ecommerceapp/views/widgets/loading.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  final DynamicPageController homePageController =
      Get.put(DynamicPageController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: whiteColor,
          elevation: 1,
          title: Paragraph(
            text: "Catgory",
            color: blackColor,
            weight: FontWeight.bold,
          ),
        ),
        body: FutureBuilder(
            future: homePageController.getDynamicPage(categoryPageTitle),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while waiting for data
                return const Loading();
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
