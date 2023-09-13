import 'dart:convert';

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/models/product_models/filter_products_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FilterProductController extends GetxController {
  Future<FilterProductsModel> getFilters() async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(
        '$baseUrl/products/options?category_id=0ff0dab9f70bb560c8e40b16fd2a3bec');

    var res = await http.post(url, headers: headers);

    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    // Parse the response body into a FilterProductsModel
    FilterProductsModel filters =
        FilterProductsModel.fromJson(json.decode(res.body));

    return filters;
  }
}
