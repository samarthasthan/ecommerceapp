// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/home_page_contoller.dart';
// ignore: unused_import
import 'package:ecommerceapp/controllers/main_menu_controller.dart';
import 'package:ecommerceapp/controllers/nagivation_animations/up_down_navigation.dart';
import 'package:ecommerceapp/models/homepage/home_page_widgets.dart';
import 'package:ecommerceapp/models/homepage/home_page_model.dart';
import 'package:ecommerceapp/views/cart_page.dart';
import 'package:ecommerceapp/views/widgets/texts/big_heading.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final HomePageController homePageController = Get.put(HomePageController());

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
              PhosphorIcons.regular.magnifyingGlass,
              color: blackColor,
            ),
            SizedBox(
              width: padding,
            ),
            GestureDetector(
              child: PhosphorIcon(
                PhosphorIcons.regular.shoppingCartSimple,
                color: blackColor,
              ),
              onTap: () {
                UpDownNavigation()
                    .navigateToPage(context, page: const CartPage());
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
            future: homePageController.getHomePage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while waiting for data
                return const Center(child: CupertinoActivityIndicator());
              } else if (snapshot.hasError) {
                // Display an error message if an error occurred
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // Display the data once it's available
                return HomePageList(
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

class HomePageList extends StatelessWidget {
  HomePageList({super.key, required this.data});
  HomePageModel data;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.widgets!.length,
        // padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          if (data.widgets![index].widgetType == 'Banner') {
            return HomePageBanner(
              data: HomePageWidgetModel.fromJson(data.widgets![index].toJson()),
            );
          }
          if (data.widgets![index].widgetType == 'ListView') {
            return HomePageListView(
              data: HomePageWidgetModel.fromJson(data.widgets![index].toJson()),
            );
          }
          if (data.widgets![index].widgetType == 'Slidder') {
            return HomePageImageSlider(
              data: HomePageWidgetModel.fromJson(data.widgets![index].toJson()),
            );
          } else {
            return Paragraph(
              text: data.widgets![index].widgetTitle.toString(),
            );
          }
        });
  }
}

class HomePageBanner extends StatelessWidget {
  HomePageBanner({super.key, required this.data});
  HomePageWidgetModel data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        data.hasHeader == true
            ? CachedNetworkImage(
                imageUrl: data.header.toString(),
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : const SizedBox(),
        CachedNetworkImage(
          imageUrl: data.widgetItems![0].imageUrl.toString(),
          height: data.itemsHeight!.h,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

class HomePageListView extends StatelessWidget {
  HomePageListView({super.key, required this.data});
  HomePageWidgetModel data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        data.hasHeader == true
            ? CachedNetworkImage(
                imageUrl: data.header.toString(),
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : const SizedBox(),
        SizedBox(
          height: data.itemsHeight!.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.widgetItems!.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: data.widgetItems![index].imageUrl.toString(),
                  fit: BoxFit.cover,
                  height: data.itemsHeight!.h,
                  width: data.itemsWidth!.w,
                );
              }),
        ),
      ],
    );
  }
}

class HomePageImageSlider extends StatelessWidget {
  HomePageImageSlider({super.key, required this.data});
  HomePageWidgetModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        data.hasHeader == true
            ? CachedNetworkImage(
                imageUrl: data.header.toString(),
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : const SizedBox(),
        CarouselSlider.builder(
          options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              initialPage: 0,
              aspectRatio: 16 / 9),
          itemCount: data.widgetItems!.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: data.widgetItems![itemIndex].imageUrl.toString(),
            height: data.itemsHeight!.h,
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
