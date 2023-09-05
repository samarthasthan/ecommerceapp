// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/dynamic_page_contoller.dart';
// ignore: unused_import
import 'package:ecommerceapp/controllers/main_menu_controller.dart';
import 'package:ecommerceapp/models/homepage/dynamic_page_widgets.dart';
import 'package:ecommerceapp/models/homepage/dynamic_page_model.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  DynamicPageModel data;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.widgets!.length,
        // padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          if (data.widgets![index].widgetType == 'Banner') {
            return HomePageBanner(
              data: DynamicPageWidgetModel.fromJson(
                  data.widgets![index].toJson()),
            );
          }
          if (data.widgets![index].widgetType == 'ListView') {
            return HomePageListView(
              data: DynamicPageWidgetModel.fromJson(
                  data.widgets![index].toJson()),
            );
          }
          if (data.widgets![index].widgetType == 'Slidder') {
            return HomePageImageSlider(
              data: DynamicPageWidgetModel.fromJson(
                  data.widgets![index].toJson()),
            );
          }
          if (data.widgets![index].widgetType == 'VeriticalListView') {
            return HomePageVerticalListView(
              data: DynamicPageWidgetModel.fromJson(
                  data.widgets![index].toJson()),
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
  DynamicPageWidgetModel data;
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
  DynamicPageWidgetModel data;
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

class HomePageVerticalListView extends StatelessWidget {
  HomePageVerticalListView({super.key, required this.data});
  DynamicPageWidgetModel data;
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
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.widgetItems!.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: data.widgetItems![index].url.toString(),
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
  DynamicPageWidgetModel data;

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
