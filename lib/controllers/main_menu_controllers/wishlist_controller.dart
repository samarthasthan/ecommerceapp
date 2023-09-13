import 'dart:convert';

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/models/wishlist_page_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WishListController extends GetxController {
  RxList<WishListModel> wishListItems = RxList<WishListModel>.empty();
  Future<RxList<WishListModel>> getWishListPage() async {
    var headers = {
      'Authorization': 'Bearer ${await getUserToken()}',
    };

    var url = Uri.parse('$baseUrl/wishlist');

    var res = await http.get(url, headers: headers);

    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    // Parse the list of items from the JSON array
    List<dynamic> jsonList = json.decode(res.body);
    wishListItems = RxList<WishListModel>(
        jsonList.map((jsonItem) => WishListModel.fromJson(jsonItem)).toList());

    return wishListItems;
  }

  Future<RxList<WishListModel>> deleteWishtlistItem({
    required String productId,
    required userId,
  }) async {
    var headers = {
      'Authorization': 'Bearer ${await getUserToken()}',
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var body = {
      "product_id": productId,
      "user_id": userId,
    };
    var bodyJson = jsonEncode(body);

    var url = Uri.parse(baseUrl + '/wishlist');
    var res = await http.delete(url, headers: headers, body: bodyJson);

    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    // Parse the list of items from the JSON array
    List<dynamic> jsonList = json.decode(res.body);
    wishListItems = RxList<WishListModel>(
        jsonList.map((jsonItem) => WishListModel.fromJson(jsonItem)).toList());

    return wishListItems;
  }

  Future<RxList<WishListModel>> addWishtlistItem({
    required String productId,
    required userId,
  }) async {
    var headers = {
      'Authorization': 'Bearer ${await getUserToken()}',
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var body = {
      "product_id": productId,
      "user_id": userId,
    };
    var bodyJson = jsonEncode(body);

    var url = Uri.parse(baseUrl + '/wishlist');
    var res = await http.post(url, headers: headers, body: bodyJson);

    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    // Parse the list of items from the JSON array
    List<dynamic> jsonList = json.decode(res.body);
    wishListItems = RxList<WishListModel>(
        jsonList.map((jsonItem) => WishListModel.fromJson(jsonItem)).toList());

    return wishListItems;
  }
}
