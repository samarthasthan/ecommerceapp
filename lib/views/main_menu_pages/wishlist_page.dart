// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/cart_controller.dart';
import 'package:ecommerceapp/controllers/main_menu_controllers/wishlist_controller.dart';
import 'package:ecommerceapp/views/widgets/buttons/basic_text_button.dart';
import 'package:ecommerceapp/views/widgets/loading.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: whiteColor,
        elevation: 1,
        title: Paragraph(
          text: "Samarth's Wishlist",
          color: blackColor,
          weight: FontWeight.bold,
        ),
      ),
      body: FutureBuilder(
          future: wishListController.getWishListPage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while waiting for data
              return const Center(child: Loading());
            } else if (snapshot.hasError) {
              // Display an error message if an error occurred
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // Display the data once it's available
              return const WishListGrid(); // Replace with your widget
            } else {
              // Default fallback, you can customize this case
              return const Text('No data available.');
            }
          }),
    );
  }
}

CartController cartController = Get.put(CartController());
WishListController wishListController = Get.put(WishListController());

class WishListGrid extends StatelessWidget {
  const WishListGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
          itemCount: wishListController.wishListItems.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              childAspectRatio: 8.7 / 16),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                        height: 200.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: wishListController
                            .wishListItems[index].productImage!),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        PhosphorIcons.regular.x,
                        size: padding,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: textPadding),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: textPadding,
                          ),
                          Paragraph(
                            text: 'FruBay',
                            weight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: textPadding,
                          ),
                          Paragraph(
                            text: wishListController
                                .wishListItems[index].productName,
                          ),
                          SizedBox(
                            height: textPadding,
                          ),
                          Row(
                            children: [
                              Paragraph(
                                text:
                                    "₹${wishListController.wishListItems[index].regularPrice}",
                                weight: FontWeight.bold,
                              ),
                              SizedBox(
                                width: textPadding,
                              ),
                              Paragraph(
                                text:
                                    "₹${wishListController.wishListItems[index].salePrice}",
                                weight: FontWeight.w200,
                              ),
                              SizedBox(
                                width: textPadding,
                              ),
                              Paragraph(
                                text:
                                    "${(((wishListController.wishListItems[index].regularPrice!.toInt() - wishListController.wishListItems[index].salePrice!.toInt()) / wishListController.wishListItems[index].salePrice!.toInt()) * 100).toInt()}%",
                                weight: FontWeight.normal,
                                color: redColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: textPadding,
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BasicTextButton(
                      isLoading: tempBool,
                      height: 20.h,
                      text: "Move to cart",
                      backgroundColor: blackColor,
                      textColor: whiteColor,
                    ),
                  ),
                  onTap: () async {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return Container(
                              color: whiteColor,
                              height: 200.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: padding,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.sp),
                                    child: Paragraph(
                                      text: "Select Size",
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.sp),
                                    child: SizedBox(
                                      height: 36.h,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: wishListController
                                              .wishListItems[index]
                                              .variations![0]
                                              .variationItems!
                                              .length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index2) {
                                            return Padding(
                                                padding: EdgeInsets.all(8.0.sp),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20.h,
                                                    width: 25.w,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: blackColor,
                                                            width: 1.sp),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    200.sp)),
                                                    child: Center(
                                                      child: Paragraph(
                                                        text: wishListController
                                                            .wishListItems[
                                                                index]
                                                            .variations![0]
                                                            .variationItems![
                                                                index2]
                                                            .variationItemName,
                                                        weight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                          }),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: BasicTextButton(
                                      isLoading: tempBool,
                                      height: bigButtonHeight,
                                      text: "Add to cart",
                                      backgroundColor: blackColor,
                                      textColor: whiteColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: BasicTextButton(
                                      isLoading: tempBool,
                                      height: bigButtonHeight,
                                      text: "Discard",
                                      backgroundColor: blackColor,
                                      textColor: whiteColor,
                                    ),
                                  )
                                ],
                              ));
                        });
                    // cartController.addCartItem(productId: wishList[index].productId!, userId: await getUserId(), variationItemsId: wishList[index].)
                  },
                )
              ],
            );
          },
        ));
  }
}
