import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  Future<bool> login({required String email, required String password}) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var body = {
      'email': email,
      'password': password,
    };
    // Convert the body map to JSON format
    var bodyJson = jsonEncode(body);

    var url = Uri.parse(baseUrl + loginUrl);
    var res = await http.post(url, headers: headers, body: bodyJson);
    if (res.statusCode == 200) {
      // Parse the response body into a LoginModel object
      var loginModel = UserModel.fromJson(json.decode(res.body));
      var jsonData = json.encode(loginModel.toJson());
      APICacheDBModel cacheDBModel =
          APICacheDBModel(key: "user_details", syncData: jsonData);
      await APICacheManager().addCacheData(cacheDBModel);

      return true; // Return true if login was successful
    } else {
      return false; // Return false if login was not successful
    }
  }
}
