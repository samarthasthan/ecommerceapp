import 'dart:convert';

import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:ecommerceapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

/////// Buttons
Rx<bool> tempBool = false.obs;
var bigButtonHeight = padding * 2.5;

const Widget divider = Divider();

const onBoardColor1 = Color(0xfffffbca);
const onBoardColor2 = Color(0xffeadefe);
const onBoardColor3 = Color(0xfffae1c3);
const onBoardColor4 = Color(0xffd1feda);
const redColor = Color(0xfff44e4e);
const greenColor = Color.fromARGB(255, 0, 193, 26);

const backgroundColor = Colors.white;
const whiteColor = backgroundColor;
const blackColor = Color(0xff16161e);
const greyColor = Colors.grey;

var textPadding = 5.sp;
var padding = 15.sp;
var curve = 0.sp;
var paragraphSize = 12.sp;
var headingSize = 15.sp;

String primaryFont = 'Gilroy-Medium';
String primaryBoldFont = 'Gilroy-Medium';

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneNumberController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController verificationCodeController =
    TextEditingController();
final TextEditingController baseUrlController = TextEditingController();

//Urls

String baseUrl = "https://4c06-117-212-45-110.ngrok-free.app";
// String baseUrl = "http://13.127.83.79";
const String registerUrl = "/register";
const String verifyOTPUrl = '/verify-otp';
const String loginUrl = '/login';
const String verifyTokenUrl = '/check-token';
const String cartUrl = '/cart';

// Dynamic Pages Titles

const String homePageTitle = 'home';
const String categoryPageTitle = 'category';

const String address =
    '9/1, M M Lane, 3 Cross Cottonpet, Chickpet\nBangalore Karnataka -560053\n+91 9557037766';

const String categoryId = "9e6524b15aa9fedf7ea04db0eff2ad32";

//////// User details
Future<UserModel> getUserDetails() async {
  var userDetailsCache = await APICacheManager().getCacheData("user_details");
  var jsonData = userDetailsCache.syncData;
  var userDetailsMap = json.decode(jsonData);

  // Now you can use tokenMap to create a LoginModel instance
  var userDetails = UserModel.fromJson(userDetailsMap);
  return userDetails;
}

getUserToken() async {
  UserModel data = await getUserDetails();
  String token = data.accessToken!;
  return token;
}

getUserId() async {
  UserModel data = await getUserDetails();
  String userId = data.userId!;
  return userId;
}
