import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: GridView.builder(
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 9.1 / 16),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: whiteColor,
            child: Column(
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                        height: 200.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl:
                            'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/10106341/2019/9/5/e5bd4bb5-b746-44b1-92fd-1b20906c60031567656798859-HRX-by-Hrithik-Roshan-Men-Tshirts-5601567656797772-1.jpg'),
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
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: padding / 3,
                      ),
                      Paragraph(
                        text: 'Ultralyte Men Black Running T-shirt',
                      ),
                      SizedBox(
                        height: padding / 3,
                      ),
                      Paragraph(
                        text: '₹3,032',
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
                  child: Container(
                    height: 20.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: greyColor),
                        borderRadius: BorderRadius.circular(curve)),
                    child: Center(
                      child: Paragraph(
                        text: 'Move to cart',
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
