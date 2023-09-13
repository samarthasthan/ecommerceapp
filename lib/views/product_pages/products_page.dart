// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/nagivation_animations/up_down_navigation.dart';
import 'package:ecommerceapp/controllers/product_model/products_controller.dart';
import 'package:ecommerceapp/views/product_pages/sku_page.dart';
import 'package:ecommerceapp/views/widgets/filter_products.dart';
import 'package:ecommerceapp/views/widgets/loading.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductsController productsController = Get.put(ProductsController());
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        iconTheme: const IconThemeData(color: blackColor),
        backgroundColor: whiteColor,
        title: Paragraph(
          text: 'Products',
          weight: FontWeight.bold,
          color: blackColor,
        ),
        leading: GestureDetector(
          onTap: () {
            Get.delete<ProductsController>;
            Get.back();
            productsController.productsListItems.clear();
          },
          child: Icon(PhosphorIcons.light.caretLeft),
        ),
      ),
      body: FutureBuilder(
          future: productsController.getProductsListPage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while waiting for data
              return const Loading();
            } else if (snapshot.hasError) {
              // Display an error message if an error occurred
              return Text('Error: ${snapshot.error}');
            } else {
              // Default fallback, you can customize this case
              return ProductsItems();
            }
          }),
    );
  }
}

class ProductsItems extends StatelessWidget {
  ProductsItems({
    super.key,
  });

  final ScrollController scrollController = ScrollController();
  ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 3) {
        // Load more data when the user is within 3 items of the end
        if (!productsController.isLoading.value &&
            !productsController.noMoreItems.value) {
          productsController.getProductsListPage();
        }
      }
    });
    return Obx(() {
      final isLoading = productsController.isLoading.value;
      final noMoreItems = productsController.noMoreItems.value;
      final productList = productsController.productsListItems;
      return Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                GridView.builder(
                    shrinkWrap: true,
                    itemCount: isLoading
                        ? productList.length // Add 1 for the loading indicator
                        : noMoreItems
                            ? productList.length
                            : productList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                            childAspectRatio: 9.9 / 16),
                    itemBuilder: (BuildContext context, int index) {
                      if (index < productList.length) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => SKUPage(
                                  productId: productList[index].productId!,
                                  skuID: productList[index].skuId!,
                                  title: productList[index].productName!,
                                ));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  CachedNetworkImage(
                                    height: 200.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    imageUrl: productList[index].productImage!,
                                  ),
                                  SizedBox(
                                    height: 200.h,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: productList[index].inWishlist ==
                                                true
                                            ? Icon(
                                                PhosphorIcons.fill.heart,
                                                color: redColor,
                                              )
                                            : Icon(
                                                PhosphorIcons.light.heart,
                                                color: whiteColor,
                                              ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: textPadding),
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          text: productList[index].productName,
                                        ),
                                        SizedBox(
                                          height: textPadding,
                                        ),
                                        Row(
                                          children: [
                                            Paragraph(
                                              text:
                                                  "₹${productList[index].regularPrice}",
                                              weight: FontWeight.bold,
                                            ),
                                            SizedBox(
                                              width: textPadding,
                                            ),
                                            Paragraph(
                                              text:
                                                  "₹${productList[index].salePrice}",
                                              weight: FontWeight.w200,
                                            ),
                                            SizedBox(
                                              width: textPadding,
                                            ),
                                            Paragraph(
                                              text:
                                                  "${(((productList[index].regularPrice!.toInt() - productList[index].salePrice!.toInt()) / productList[index].salePrice!.toInt()) * 100).toInt()}%",
                                              weight: FontWeight.normal,
                                              color: redColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return const Loading();
                      }
                    }),
                isLoading == true
                    ? Column(
                        children: [
                          const Loading(),
                          Paragraph(
                            text: 'Fetching more products for you.',
                          ),
                          SizedBox(
                            height: padding * 3,
                          )
                        ],
                      )
                    : noMoreItems == true
                        ? Column(
                            children: [
                              Center(child: Paragraph(text: "No more items")),
                              SizedBox(
                                height: padding * 3,
                              )
                            ],
                          )
                        : const SizedBox(),
                SizedBox(
                  height: 50.h,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: whiteColor,
                  border:
                      Border(top: BorderSide(color: greyColor, width: 0.sp))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIcons.light.funnelSimple,
                        ),
                        SizedBox(
                          width: textPadding,
                        ),
                        Paragraph(
                          text: "Sort",
                        )
                      ],
                    ),
                    const SizedBox(),
                    GestureDetector(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            PhosphorIcons.light.slidersHorizontal,
                          ),
                          SizedBox(
                            width: textPadding,
                          ),
                          Paragraph(
                            text: "Filter",
                          )
                        ],
                      ),
                      onTap: () {
                        UpDownNavigation()
                            .navigateToPage(context, page: FilterProducts());
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
