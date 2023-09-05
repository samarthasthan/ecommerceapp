import 'dart:convert';

import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/models/cart_page_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  Future<List<CartModel>> getCartPage() async {
    var token = await APICacheManager().getCacheData("login_token");
    var headers = {
      'Authorization': 'Bearer ${token.syncData}',
    };

    // Include the 'email' query parameter in the URL
    var url = Uri.parse('$baseUrl/cart');

    var res = await http.get(url, headers: headers);

    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }

    // Parse the list of items from the JSON array
    List<dynamic> jsonList = json.decode(res.body);
    List<CartModel> cartItems =
        jsonList.map((jsonItem) => CartModel.fromJson(jsonItem)).toList();

    return cartItems;
  }
}
