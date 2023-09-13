// ignore_for_file: depend_on_referenced_packages

import 'package:ecommerceapp/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TokenVerify extends GetxController {
  Future<bool> verify() async {
    var headers = {
      'Authorization': 'Bearer ${await getUserToken()}',
    };

    var url = Uri.parse(baseUrl + verifyTokenUrl);
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }
}
