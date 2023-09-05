// ignore_for_file: must_be_immutable

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';

class BasicTextButton extends StatelessWidget {
  BasicTextButton({super.key, this.text, this.backgroundColor, this.textColor});
  String? text;
  Color? backgroundColor;
  Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: padding * 2.5,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(curve)),
        child: Center(
          child: Paragraph(
            text: text,
            color: textColor,
            weight: FontWeight.bold,
          ),
        ));
  }
}
