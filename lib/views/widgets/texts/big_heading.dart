// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigHeading extends StatelessWidget {
  BigHeading({super.key, this.text, this.weight, this.color, this.size});

  String? text = 'N/A';
  FontWeight? weight = FontWeight.normal;
  Color? color = Colors.black;
  TextAlign? align = TextAlign.center;
  double? size = 32.sp;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(fontSize: size, fontWeight: weight, color: color),
      textAlign: align,
    );
  }
}
