// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/wishlist_controller.dart';
import 'package:ecommerceapp/models/wishlist_page_model.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          future: WishListController().getWishListPage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while waiting for data
              return const Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasError) {
              // Display an error message if an error occurred
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // Display the data once it's available
              return WishListGrid(
                wishList: snapshot.data!,
              ); // Replace with your widget
            } else {
              // Default fallback, you can customize this case
              return const Text('No data available.');
            }
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class WishListGrid extends StatelessWidget {
  WishListGrid({super.key, required this.wishList});

  List<WishListModel> wishList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: wishList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          childAspectRatio: 9 / 16),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: wishList[index].productImage!),
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
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
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
                      text: wishList[index].productName,
                    ),
                    SizedBox(
                      height: textPadding,
                    ),
                    Row(
                      children: [
                        Paragraph(
                          text: "₹${wishList[index].regularPrice}",
                          weight: FontWeight.bold,
                        ),
                        SizedBox(
                          width: textPadding,
                        ),
                        Paragraph(
                          text: "₹${wishList[index].salePrice}",
                          weight: FontWeight.w200,
                        ),
                        SizedBox(
                          width: textPadding,
                        ),
                        Paragraph(
                          text:
                              "${(((wishList[index].regularPrice!.toInt() - wishList[index].salePrice!.toInt()) / wishList[index].salePrice!.toInt()) * 100).toInt()}%",
                          weight: FontWeight.normal,
                          color: lightBlue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 8.w, right: 8.w, top: textPadding),
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
    );
  }
}
