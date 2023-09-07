// ignore_for_file: must_be_immutable

import 'package:ecommerceapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Paragraph extends StatelessWidget {
  Paragraph(
      {super.key,
      this.text,
      this.weight,
      this.color,
      this.align,
      this.decoration});

  String? text = 'N/A';
  FontWeight? weight = FontWeight.normal;
  Color? color = Colors.black;
  TextAlign? align = TextAlign.center;
  TextDecoration? decoration = TextDecoration.none;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!.isNotEmpty ? text! : "N/A",
      style: TextStyle(
          fontFamily: primaryFont,
          fontSize: 12.sp,
          fontWeight: weight,
          color: color,
          decoration: decoration),
      textAlign: align,
    );
  }
}
