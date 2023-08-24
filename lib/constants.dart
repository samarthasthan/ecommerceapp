import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const onBoardColor1 = Color(0xfffffbca);
const onBoardColor2 = Color(0xffeadefe);
const onBoardColor3 = Color(0xfffae1c3);
const onBoardColor4 = Color(0xffd1feda);
const lightBlue = Color(0xff0171db);

const whiteColor = Colors.white;
const blackColor = Colors.black;
const greyColor = Colors.grey;

var padding = 15.sp;

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneNumberController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController verificationCodeController =
    TextEditingController();
final TextEditingController baseUrlController = TextEditingController();

//Urls

String baseUrl = "https://c3e4-2a09-bac1-36a0-1d0-00-29e-e0.ngrok-free.app";
const String registerUrl = "/register";
const String verifyOTPUrl = '/verify-otp';
const String loginUrl = '/login';
const String verifyTokenUrl = '/protected-resource';
