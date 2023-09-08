import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

String baseUrl = "http://3.6.94.231";
// String baseUrl = "http://13.127.83.79";
const String registerUrl = "/register";
const String verifyOTPUrl = '/verify-otp';
const String loginUrl = '/login';
const String verifyTokenUrl = '/check-token';

// Dynamic Pages Titles

const String homePageTitle = 'home';
const String categoryPageTitle = 'category';

const String address =
    '9/1, M M Lane, 3 Cross Cottonpet, Chickpet\nBangalore Karnataka -560053\n+91 9557037766';

const String category_id = "0ff0dab9f70bb560c8e40b16fd2a3bec";
