// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerceapp/models/dynamic_page_models/dynamic_page_model.dart';
import 'package:ecommerceapp/models/dynamic_page_models/dynamic_page_widgets.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DynamicPageList extends StatelessWidget {
  DynamicPageList({super.key, required this.data});
  DynamicPageModel data;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.widgets!.length,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          if (data.widgets![index].widgetType == 'Banner') {
            return DynamicPageBanner(
              data: DynamicPageWidgetModel.fromJson(
                  data.widgets![index].toJson()),
            );
          }
          if (data.widgets![index].widgetType == 'ListView') {
            return DynamicPageListView(
              data: DynamicPageWidgetModel.fromJson(
                  data.widgets![index].toJson()),
            );
          }
          if (data.widgets![index].widgetType == 'Slidder') {
            return DynamicPageImageSlider(
              data: DynamicPageWidgetModel.fromJson(
                  data.widgets![index].toJson()),
            );
          }
          if (data.widgets![index].widgetType == 'VeriticalListView') {
            return DynamicPageVerticalListView(
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

class DynamicPageVerticalListView extends StatelessWidget {
  DynamicPageVerticalListView({super.key, required this.data});
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

class DynamicPageBanner extends StatelessWidget {
  DynamicPageBanner({super.key, required this.data});
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

class DynamicPageListView extends StatelessWidget {
  DynamicPageListView({super.key, required this.data});
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

class DynamicPageImageSlider extends StatelessWidget {
  DynamicPageImageSlider({super.key, required this.data});
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
