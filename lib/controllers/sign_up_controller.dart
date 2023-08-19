// ignore_for_file: depend_on_referenced_packages

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
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data =
        'first_name=$firstName&last_name=$lastName&email=$email&phone=$phoneNo&password=$password';

    var url = Uri.parse(baseUrl + registerUrl);
    var res = await http.post(url, headers: headers, body: data);
    if (res.statusCode != 200) {
      return false;
    }
    return true;
  }
}
