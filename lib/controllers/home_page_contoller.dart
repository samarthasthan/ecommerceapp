// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/models/homepage/home_page_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  Future<HomePageModel> getHomePage() async {
    var headers = {
      'accept': 'application/json',
    };

    var params = {
      'page_title': 'HomePage',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    var url = Uri.parse('$baseUrl/app/pages/title?$query');
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    print("homepage call");
    return HomePageModel.fromJson(json.decode(res.body));
  }
}
