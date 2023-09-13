import 'dart:convert';

import 'package:ecommerceapp/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VerifyOTP extends GetxController {
  Future<bool> verify({required String email, required String otp}) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var body = {
      'email': email,
      'otp': otp,
    };

    // Convert the body map to JSON format
    var bodyJson = jsonEncode(body);

    var url = Uri.parse(baseUrl + verifyOTPUrl);
    var res = await http.post(url, headers: headers, body: bodyJson);
    if (res.statusCode != 200) return false;
    return true;
  }
}
