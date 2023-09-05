// ignore_for_file: must_be_immutable

import 'package:ecommerceapp/constants.dart';
import 'package:flutter/material.dart';

class BigHeading extends StatelessWidget {
  BigHeading({super.key, this.text, this.weight, this.color, this.size});

  String? text = 'N/A';
  FontWeight? weight = FontWeight.normal;
  Color? color = Colors.black;
  TextAlign? align = TextAlign.center;
  double? size;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          fontSize: size ?? headingSize, fontWeight: weight, color: color),
      textAlign: align,
    );
  }
}
