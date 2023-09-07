// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/cart_controller.dart';
import 'package:ecommerceapp/models/cart_page_model.dart';
import 'package:ecommerceapp/views/pages/sku_page.dart';
import 'package:ecommerceapp/views/widgets/buttons/basic_text_button.dart';
import 'package:ecommerceapp/views/widgets/loading.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  CartController cartController = Get.put(CartController());
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
          text: 'Cart',
          weight: FontWeight.bold,
          color: blackColor,
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
            Get.delete<CartController>();
          },
          child: Icon(PhosphorIcons.light.caretLeft),
        ),
      ),
      body: FutureBuilder<RxList<CartModel>>(
          future: cartController.getCartPage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while waiting for data
              return const Loading();
            } else if (snapshot.hasError) {
              // Display an error message if an error occurred
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Obx(() => cartController.cartItems.isEmpty
                  ? Center(
                      child: Paragraph(
                        text: "Cart is empty, please add some items to cart.",
                      ),
                    )
                  : CartItems());
            } else {
              // Default fallback, you can customize this case
              return const Text('No data available.');
            }
          }),
    );
  }
}

class CartItems extends StatelessWidget {
  CartItems({super.key});

  CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  color: whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: textPadding,
                              vertical: textPadding / 2),
                          child: Row(
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
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: textPadding,
                              vertical: textPadding / 2),
                          child: Paragraph(
                            text:
                                '15% Instant Discount on OneCard Credit Cards on min spend of ₹3,000 TCA.',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: textPadding,
                              vertical: textPadding / 2),
                          child: Row(
                            children: [
                              Paragraph(
                                text: 'Show more',
                                color: lightBlue,
                              ),
                              SizedBox(
                                width: textPadding,
                              ),
                              Icon(
                                PhosphorIcons.light.caretDown,
                                color: lightBlue,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: padding / 2,
                ),
                ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CartItem(
                            item: cartController.cartItems[index],
                          ),
                          SizedBox(
                            height: index != cartController.cartItems.length - 1
                                ? padding / 2
                                : 0,
                          ),
                        ],
                      );
                    }),
                SizedBox(
                  height: padding / 2,
                ),
                const Divider(),
                Container(
                  color: whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: textPadding,
                              vertical: textPadding / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                PhosphorIcons.light.tag,
                              ),
                              SizedBox(
                                width: textPadding,
                              ),
                              Paragraph(
                                text: 'Apply Coupon',
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: padding / 2,
                ),
                Container(
                  color: whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Paragraph(
                          text: 'Price Detials',
                          weight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: textPadding,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Paragraph(
                              text: 'Total MRP',
                            ),
                            Paragraph(
                              text: '₹${cartController.totalMRP.value}',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: textPadding,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Paragraph(
                              text: 'Discount on MRP',
                            ),
                            Paragraph(
                              text: '-₹${cartController.totalDiscount.value}',
                              color: greenColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: textPadding,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Paragraph(
                              text: 'Coupon Discount',
                            ),
                            Paragraph(
                              text: 'Apply Coupon',
                              color: lightBlue,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: textPadding,
                        ),
                        const Divider(),
                        SizedBox(
                          height: textPadding,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Paragraph(
                              text: 'Total Amount',
                              weight: FontWeight.bold,
                            ),
                            Paragraph(
                              text:
                                  '₹${(cartController.totalMRP.value - cartController.totalDiscount.value).toString()}',
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: textPadding,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: padding * 2.5 + 28.h,
                ),
                SizedBox(
                  height: textPadding,
                ),
              ],
            ),
          ),
          Visibility(
            visible: cartController.cartItems.isEmpty ? false : true,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: whiteColor,
                height: padding * 2.5 + 28.h,
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: BasicTextButton(
                    text: 'Place Order',
                    textColor: whiteColor,
                    backgroundColor: blackColor,
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}

class CartItem extends StatelessWidget {
  CartItem({super.key, required this.item});

  CartModel item;
  String? selectedSize;
  double? regularPrice, salePrice;
  CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    item.allVariationItems?.forEach((variationItem) {
      if (variationItem.variationItemId == item.currentVariation) {
        selectedSize = variationItem.variationItemName;
        regularPrice = variationItem.regularPrice;
        salePrice = variationItem.salePrice;
      }
    });
    return Container(
      color: whiteColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => SKUPage(
                    productId: item.productId!,
                    skuID: item.skuID!,
                    title: item.productName!,
                  ));
            },
            child: CachedNetworkImage(
                height: 140.h, fit: BoxFit.cover, imageUrl: item.productImage!),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: textPadding,
                ),
                Row(
                  children: [
                    Paragraph(
                      text: 'FruBay',
                      weight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: 160.w,
                    ),
                    GestureDetector(
                        onTap: () async {
                          await cartController
                              .deleteCartItem(item.productId.toString());

                          // Update the cart controller
                          cartController.update();
                        },
                        child: Icon(PhosphorIcons.light.x))
                  ],
                ),
                SizedBox(
                  height: textPadding,
                ),
                Paragraph(
                  text: item.productName,
                ),
                SizedBox(
                  height: textPadding,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 50.w,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration.collapsed(
                            hintText: '',
                            hintStyle: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          value: selectedSize,
                          items: item.allVariationItems?.map((variationItem) {
                            return DropdownMenuItem<String>(
                              value: variationItem.variationItemName,
                              child: Paragraph(
                                text: '${variationItem.variationItemName}',
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) async {
                            var variationItemId = '';
                            for (var variationItem in item.allVariationItems!) {
                              if (variationItem.variationItemName == newValue) {
                                variationItemId =
                                    variationItem.variationItemId!;
                              }
                            }

                            await cartController.updateCartItem(
                                item.productId.toString(),
                                item.quantity!,
                                variationItemId);
                            cartController.update();
                          },
                        )),
                    SizedBox(
                      width: textPadding,
                    ),
                    SizedBox(
                      width: 50.w,
                      child: DropdownButtonFormField<int>(
                        decoration:
                            const InputDecoration.collapsed(hintText: ''),
                        value:
                            item.quantity, // Assuming item.quantity is an int
                        items: List.generate(6, (index) {
                          return DropdownMenuItem<int>(
                            value: index +
                                1, // Assuming you want values from 1 to 10
                            child: Paragraph(
                              text: '${index + 1}',
                            ),
                          );
                        }),
                        onChanged: (newValue) async {
                          await cartController.updateCartItem(
                              item.productId.toString(),
                              newValue!,
                              item.currentVariation.toString());
                          cartController.update();
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: textPadding,
                ),
                Row(
                  children: [
                    Paragraph(
                      text: "₹${salePrice!.toInt()}",
                      weight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: textPadding,
                    ),
                    Paragraph(
                      text: "₹${regularPrice!.toInt()}",
                      weight: FontWeight.w200,
                    ),
                    SizedBox(
                      width: textPadding,
                    ),
                    Paragraph(
                      text:
                          "${((regularPrice!.toInt() - salePrice!.toInt()) / regularPrice!.toInt() * 100).toInt()}%",
                      weight: FontWeight.normal,
                      color: greenColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: textPadding,
                ),
                Row(
                  children: [
                    Icon(
                      PhosphorIcons.thin.arrowUDownLeft,
                    ),
                    SizedBox(
                      width: textPadding,
                    ),
                    Paragraph(
                      text: '14 Days',
                      weight: FontWeight.bold,
                    ),
                    Paragraph(
                      text: ' return available',
                      weight: FontWeight.normal,
                    ),
                  ],
                ),
                SizedBox(
                  height: textPadding,
                ),
                Row(
                  children: [
                    Icon(
                      PhosphorIcons.thin.truck,
                    ),
                    SizedBox(
                      width: textPadding,
                    ),
                    Paragraph(
                      text: 'Delivery by',
                      weight: FontWeight.normal,
                    ),
                    Paragraph(
                      text: ' 10 Sep 2023',
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
