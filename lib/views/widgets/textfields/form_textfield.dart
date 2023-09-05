// ignore_for_file: must_be_immutable

import 'package:ecommerceapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FormTextField extends StatelessWidget {
  FormTextField({
    super.key,
    this.text,
    this.controller,
    this.isSecret,
    this.onChange,
    this.isValid,
  });

  String? text = "N/A";
  TextEditingController? controller;
  bool? isSecret = false;
  ValueChanged<String>? onChange;
  bool? isValid;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: controller,
        cursorColor: blackColor,
        onChanged: onChange,
        obscureText: isSecret.isNull ? false : isSecret!,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: blackColor,
            fontSize: 12.sp,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: greyColor, width: 1.h),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: blackColor, width: 1.h),
          ),
        ),
      ),
    );
  }
}
