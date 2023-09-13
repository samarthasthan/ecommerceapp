import 'dart:convert';

import 'package:ecommerceapp/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  Future<bool> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required int phoneNo,
    required String password,
  }) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json', // Use JSON content type
    };

    var body = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phoneNo.toString(), // Convert phoneNo to a string
      'password': password,
    };

    // Convert the body map to JSON format
    var bodyJson = jsonEncode(body);

    var url = Uri.parse(baseUrl + registerUrl);
    var res = await http.post(url, headers: headers, body: bodyJson);

    if (res.statusCode != 200) {
      return false;
    }
    return true;
  }
}
