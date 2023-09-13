// ignore_for_file: must_be_immutable

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/filter_prodcuts_controller.dart';
import 'package:ecommerceapp/models/product_models/filter_products_model.dart';
import 'package:ecommerceapp/views/widgets/loading.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vertical_tabs_flutter/vertical_tabs.dart';

class FilterProducts extends StatelessWidget {
  FilterProducts({super.key});

  FilterProductController filterProductController =
      Get.put(FilterProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          iconTheme: const IconThemeData(color: blackColor),
          backgroundColor: whiteColor,
          title: Paragraph(
            text: 'Filter',
            weight: FontWeight.bold,
            color: blackColor,
          ),
          leading: GestureDetector(
            onTap: () {
              // Get.delete<ProductsController>;
              Get.back();
              // productsController.productsListItems.clear();
            },
            child: Icon(PhosphorIcons.light.caretLeft),
          ),
        ),
        body: FutureBuilder(
            future: filterProductController.getFilters(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while waiting for data
                return const Loading();
              } else if (snapshot.hasError) {
                // Display an error message if an error occurred
                return Text('Error: ${snapshot.error}');
              } else {
                // Default fallback, you can customize this case
                return FilterItems(
                  data: snapshot.data!,
                );
              }
            })));
  }
}

class FilterItems extends StatelessWidget {
  FilterItems({super.key, required this.data});

  FilterProductsModel data;

  @override
  Widget build(BuildContext context) {
    return VerticalTabs(
      indicatorColor: redColor,
      selectedTabBackgroundColor: redColor.withOpacity(0.1),
      tabsWidth: 150,
      backgroundColor: whiteColor,
      tabs: [
        Tab(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Paragraph(
            text: "Color",
          ),
        )),
        Tab(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Paragraph(
            text: "Size",
          ),
        )),
      ],
      contents: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: data.colors!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var color = data.colors![index].colorHex;
                color = color!.replaceAll("#", "");
                color = '0xff$color';
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 20.h,
                          width: 23.w,
                          decoration: BoxDecoration(
                              color: Color(int.parse(color)),
                              borderRadius: BorderRadius.circular(200.sp))),
                      SizedBox(
                        width: padding,
                      ),
                      Paragraph(
                        text: data.colors![index].color,
                      )
                    ],
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: data.options!.size!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                        child: Checkbox(
                            shape: OvalBorder(),
                            value: false,
                            onChanged: (value) {}),
                      ),
                      SizedBox(
                        width: padding,
                      ),
                      Paragraph(
                        text: data.options!.size![index].name,
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
