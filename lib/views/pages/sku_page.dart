// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerceapp/controllers/discount_controller.dart';
import 'package:ecommerceapp/controllers/sku_controller.dart';
import 'package:ecommerceapp/models/sku_page_model.dart';
import 'package:ecommerceapp/views/widgets/buttons/basic_text_button.dart';
import 'package:ecommerceapp/views/widgets/loading.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants.dart';

class SKUPage extends StatelessWidget {
  SKUPage(
      {super.key,
      required this.productId,
      required this.skuID,
      required this.title});

  SKUController skuController = Get.put(SKUController());

  String productId;
  String skuID;
  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        iconTheme: const IconThemeData(color: blackColor),
        backgroundColor: whiteColor,
        title: Paragraph(
          text: title,
          color: blackColor,
          weight: FontWeight.bold,
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
            Get.delete<SKUController>();
          },
          child: Icon(PhosphorIcons.light.caretLeft),
        ),
      ),
      body: FutureBuilder<Rx<SKUModel?>>(
          future: skuController.getSKUPage(skuID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while waiting for data
              return const Loading();
            } else if (snapshot.hasError) {
              // Display an error message if an error occurred
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              skuController.currentProduct.value =
                  skuController.getProductIndex(productId);
              return ProductItem(
                data: snapshot.data!,
              );
            } else {
              // Default fallback, you can customize this case
              return const Text('No data available.');
            }
          }),
    );
  }
}

class ProductItem extends StatelessWidget {
  ProductItem({super.key, required this.data});

  final RxInt _currentIndex = 0.obs;

  Rx<SKUModel?> data;

  // To keep track of the current page
  final CarouselController _carouselController = CarouselController();

  final SKUController skuController = Get.put(SKUController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    aspectRatio: 9 / 11,
                    onPageChanged: (index, reason) {
                      _currentIndex.value = index;
                    },
                  ),
                  itemCount: data
                      .value!
                      .products![skuController.currentProduct.value]
                      .productImages!
                      .length,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: data
                        .value!
                        .products![skuController.currentProduct.value]
                        .productImages![itemIndex]
                        .mediumImageUrl!,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 7.h,
                  left: 360.h / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        data
                            .value!
                            .products![skuController.currentProduct.value]
                            .productImages!
                            .length, (index) {
                      return Obx(() => Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 6.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? blackColor
                                  : Colors
                                      .grey, // You can customize the indicator color
                            ),
                          ));
                    }),
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    Container(
                      color: whiteColor,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Paragraph(
                                text: 'FruBay',
                                weight: FontWeight.bold,
                              ),
                              Paragraph(
                                text: 'Explore brand',
                                weight: FontWeight.bold,
                                color: redColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: textPadding,
                          ),
                          Paragraph(
                            text: data
                                .value!
                                .products![skuController.currentProduct.value]
                                .productName,
                          ),
                          SizedBox(
                            height: textPadding,
                          ),
                          Row(
                            children: [
                              Paragraph(
                                text:
                                    "₹${data.value!.products![skuController.currentProduct.value].variations![0].variationItems![skuController.currentVariation.value].salePrice!}",
                                weight: FontWeight.bold,
                              ),
                              SizedBox(
                                width: textPadding,
                              ),
                              Paragraph(
                                text:
                                    "₹${data.value!.products![skuController.currentProduct.value].variations![0].variationItems![skuController.currentVariation.value].regularPrice!}",
                                weight: FontWeight.w200,
                              ),
                              SizedBox(
                                width: textPadding,
                              ),
                              Paragraph(
                                text:
                                    '${discountCalulator(data.value!.products![skuController.currentProduct.value].variations![0].variationItems![skuController.currentVariation.value].salePrice!, data.value!.products![skuController.currentProduct.value].variations![0].variationItems![skuController.currentVariation.value].regularPrice!)}%',
                                weight: FontWeight.normal,
                                color: greenColor,
                              ),
                            ],
                          ),
                          const Divider()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: textPadding,
                    ),
                    Container(
                      color: whiteColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                PhosphorIcons.light.percent,
                              ),
                              SizedBox(
                                width: textPadding,
                              ),
                              Paragraph(
                                text: 'Avialable Offers!',
                              )
                            ],
                          ),
                          Paragraph(
                            text:
                                '15% Instant Discount on OneCard Credit Cards on min spend of ₹3,000 TCA.',
                          ),
                          Row(
                            children: [
                              Paragraph(
                                text: 'Show more',
                                color: redColor,
                              ),
                              SizedBox(
                                width: textPadding,
                              ),
                              Icon(
                                PhosphorIcons.light.caretDown,
                                color: redColor,
                              )
                            ],
                          ),
                          const Divider()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: textPadding,
                    ),
                    Container(
                      color: whiteColor,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Paragraph(
                                text: 'Color',
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 36.h,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.value!.products!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var color =
                                      data.value!.products![index].colorHex;
                                  color = color!.replaceAll("#", "");
                                  color = '0xff$color';

                                  return Padding(
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: GestureDetector(
                                      onTap: () {
                                        skuController.getProductIndex(data
                                            .value!
                                            .products![index]
                                            .productId!);
                                      },
                                      child: Container(
                                        height: 20.h,
                                        width: 25.w,
                                        decoration: skuController
                                                    .currentProduct.value ==
                                                index
                                            ? BoxDecoration(
                                                border: Border.all(
                                                    width: 1.sp,
                                                    color: blackColor),
                                                color: Color(int.parse(color)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        200.sp))
                                            : BoxDecoration(
                                                border: Border.all(
                                                    width: 1.sp,
                                                    color: greyColor),
                                                color: Color(int.parse(color)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        200.sp)),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          const Divider(),
                          SizedBox(
                            height: textPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Paragraph(
                                text: 'Size',
                                weight: FontWeight.bold,
                              ),
                              Paragraph(
                                text: 'Size Chart',
                                weight: FontWeight.bold,
                                color: redColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 36.h,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: data
                                    .value!
                                    .products![
                                        skuController.currentProduct.value]
                                    .variations![0]
                                    .variationItems!
                                    .length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: GestureDetector(
                                        onTap: () {
                                          skuController
                                              .getProductVariationIndex(data
                                                  .value!
                                                  .products![skuController
                                                      .currentProduct.value]
                                                  .variations![0]
                                                  .variationItems![index]
                                                  .variationItemName!);
                                        },
                                        child: Obx(
                                          () => Container(
                                            height: 20.h,
                                            width: 25.w,
                                            decoration: skuController
                                                        .currentVariation
                                                        .value ==
                                                    index
                                                ? BoxDecoration(
                                                    border: Border.all(
                                                        color: blackColor,
                                                        width: 1.sp),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            200.sp))
                                                : BoxDecoration(
                                                    border: Border.all(
                                                        color: greyColor,
                                                        width: 1.sp),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            200.sp)),
                                            child: Center(
                                              child: Paragraph(
                                                text: data
                                                    .value!
                                                    .products![skuController
                                                        .currentProduct.value]
                                                    .variations![0]
                                                    .variationItems![index]
                                                    .variationItemName,
                                                weight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )),
                                  );
                                }),
                          ),
                          const Divider(),
                          SizedBox(
                            height: textPadding,
                          ),
                          BasicTextButton(
                            text: "Wishlist",
                            backgroundColor: blackColor,
                            textColor: whiteColor,
                          ),
                          SizedBox(
                            height: textPadding,
                          ),
                          BasicTextButton(
                            text: "Add to cart",
                            backgroundColor: redColor,
                            textColor: whiteColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: padding,
                    ),
                    Container(
                      color: whiteColor,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Paragraph(
                            text: 'Product Details-',
                            weight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: textPadding,
                          ),
                          Paragraph(
                            text: 'Color:',
                            weight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: textPadding,
                          ),
                          Paragraph(
                            text: data
                                .value!
                                .products![skuController.currentProduct.value]
                                .color,
                          ),
                          const Divider(),
                          SizedBox(
                            height: textPadding,
                          ),
                          ListView.builder(
                              itemCount: data
                                  .value!
                                  .products![skuController.currentProduct.value]
                                  .productDetails!
                                  .length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(0),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Paragraph(
                                      text: data
                                          .value!
                                          .products![skuController
                                              .currentProduct.value]
                                          .productDetails![index]
                                          .heading,
                                      weight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: textPadding,
                                    ),
                                    ListView.builder(
                                        padding: const EdgeInsets.all(0),
                                        itemCount: data
                                            .value!
                                            .products![skuController
                                                .currentProduct.value]
                                            .productDetails![index]
                                            .bulletPoints!
                                            .length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index2) {
                                          return Paragraph(
                                            text: data
                                                .value!
                                                .products![skuController
                                                    .currentProduct.value]
                                                .productDetails![index]
                                                .bulletPoints![index2]
                                                .point,
                                          );
                                        }),
                                    SizedBox(
                                      height: textPadding,
                                    ),
                                    const Divider(),
                                  ],
                                );
                              }),
                          SizedBox(
                            height: textPadding,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: textPadding,
                    ),
                    Container(
                      color: whiteColor,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Paragraph(
                            text: 'Easy 14 days returns and exchanges',
                            weight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: textPadding,
                          ),
                          Paragraph(
                            text:
                                'Choose to return or echange for a different size (if avaliable) within 14 days.',
                          ),
                          SizedBox(
                            height: textPadding,
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: padding,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
