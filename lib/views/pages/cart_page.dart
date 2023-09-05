import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/views/widgets/buttons/basic_text_button.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Stack(children: [
        SingleChildScrollView(
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
                            horizontal: textPadding, vertical: textPadding / 2),
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
                            horizontal: textPadding, vertical: textPadding / 2),
                        child: Paragraph(
                          text:
                              '15% Instant Discount on OneCard Credit Cards on min spend of ₹3,000 TCA.',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: textPadding, vertical: textPadding / 2),
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
              SizedBox(
                height: padding / 2,
              ),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const CartItem(),
                        SizedBox(
                          height: index != 2 ? padding / 2 : 0,
                        ),
                      ],
                    );
                  }),
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: textPadding, vertical: textPadding / 2),
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
                            text: '₹6,064',
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
                            text: '-₹3,066',
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
                            text: '₹2,998',
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
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: whiteColor,
            height: padding * 2.5 + 28.h,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 8.0.w, right: 8.0.w, bottom: 20.h, top: 8.0.h),
              child: BasicTextButton(
                text: 'Place Order',
                textColor: whiteColor,
                backgroundColor: blackColor,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
              height: 140.h,
              fit: BoxFit.cover,
              imageUrl:
                  'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/10106341/2019/9/5/e5bd4bb5-b746-44b1-92fd-1b20906c60031567656798859-HRX-by-Hrithik-Roshan-Men-Tshirts-5601567656797772-1.jpg'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                  text: 'Ultralyte Men Black Running T-shirt',
                ),
                SizedBox(
                  height: textPadding,
                ),
                Row(
                  children: [
                    Container(
                      color: greyBackground,
                      child: Padding(
                        padding: EdgeInsets.all(textPadding),
                        child: Paragraph(
                          text: 'Size: S',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: textPadding,
                    ),
                    Container(
                      color: greyBackground,
                      child: Padding(
                        padding: EdgeInsets.all(textPadding),
                        child: Paragraph(
                          text: 'Qty: 1',
                        ),
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
                      text: '₹1,499',
                      weight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: textPadding,
                    ),
                    Paragraph(
                      text: '₹3,032',
                      weight: FontWeight.w200,
                    ),
                    SizedBox(
                      width: textPadding,
                    ),
                    Paragraph(
                      text: '64% OFF',
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
