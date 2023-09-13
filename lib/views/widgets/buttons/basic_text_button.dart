// ignore_for_file: must_be_immutable

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicTextButton extends StatelessWidget {
  BasicTextButton(
      {super.key,
      this.text,
      this.backgroundColor,
      this.textColor,
      required this.isLoading,
      required this.height});
  String? text;
  Color? backgroundColor;
  Color? textColor;
  Rx<bool> isLoading = false.obs;
  double height;
  @override
  Widget build(BuildContext context) {
    return Obx(() => isLoading.value == false
        ? Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(curve)),
            child: Center(
              child: Paragraph(
                text: text,
                color: textColor,
                weight: FontWeight.bold,
              ),
            ))
        : Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(curve)),
            child: Center(
                child: SizedBox(
              height: padding * 1.5,
              width: padding * 1.5,
              child: const CircularProgressIndicator(
                color: whiteColor,
              ),
            ))));
  }
}
