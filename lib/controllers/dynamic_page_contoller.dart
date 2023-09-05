// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/models/homepage/dynamic_page_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DynamicPageController extends GetxController {
  Future<DynamicPageModel> getDynamicPage(String title) async {
    var headers = {
      'accept': 'application/json',
    };

    var params = {
      'page_title': title,
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    var url = Uri.parse('$baseUrl/app/page?$query');
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    print("Calling $title API");
    return DynamicPageModel.fromJson(json.decode(res.body));
  }
}
