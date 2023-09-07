import 'dart:convert';

import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/models/cart_page_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  RxList<CartModel> cartItems = RxList<CartModel>.empty();
  late RxDouble totalMRP = 0.0.obs;
  late RxDouble totalDiscount = 0.0.obs;

  Future<RxList<CartModel>> getCartPage() async {
    try {
      var token = await APICacheManager().getCacheData("login_token");
      var headers = {
        'Authorization': 'Bearer ${token.syncData}',
        'accept': 'application/json',
        'Content-Type': 'application/json',
      };

      var url = Uri.parse('$baseUrl/cart');

      var res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        List<dynamic> jsonList = json.decode(res.body);
        cartItems = RxList<CartModel>(
            jsonList.map((jsonItem) => CartModel.fromJson(jsonItem)).toList());
// Reset values
        totalMRP.value = 0;
        totalDiscount.value = 0;
        for (var cartitem in cartItems) {
          cartitem.allVariationItems?.forEach((variationItem) {
            if (variationItem.variationItemId == cartitem.currentVariation) {
              totalMRP.value +=
                  variationItem.regularPrice! * cartitem.quantity!.toInt();
              totalDiscount.value +=
                  (variationItem.regularPrice! - variationItem.salePrice!) *
                      cartitem.quantity!.toInt();
            }
          });
        }
        return cartItems;
      } else {
        throw Exception('http.get error: statusCode= ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> deleteCartItem(String productId) async {
    try {
      var token = await APICacheManager().getCacheData("login_token");
      var headers = {
        'Authorization': 'Bearer ${token.syncData}',
        'accept': 'application/json',
        'Content-Type': 'application/json',
      };

      var body = {"product_id": productId.toString()};

      var bodyJson = jsonEncode(body);

      var url = Uri.parse('$baseUrl/cart');

      var res = await http.delete(url, headers: headers, body: bodyJson);

      if (res.statusCode == 200) {
        List<dynamic> jsonList = json.decode(res.body);
        // Create a new RxList and assign it to cartItems
        cartItems.assignAll(
            jsonList.map((jsonItem) => CartModel.fromJson(jsonItem)).toList());
// Reset values
        totalMRP.value = 0;
        totalDiscount.value = 0;
        for (var cartitem in cartItems) {
          cartitem.allVariationItems?.forEach((variationItem) {
            if (variationItem.variationItemId == cartitem.currentVariation) {
              totalMRP.value +=
                  variationItem.regularPrice! * cartitem.quantity!.toInt();
              totalDiscount.value +=
                  (variationItem.regularPrice! - variationItem.salePrice!) *
                      cartitem.quantity!.toInt();
            }
          });
        }
      } else {
        throw Exception('http.delete error: statusCode= ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> updateCartItem(
      String productId, int quantity, String variation_item_id) async {
    try {
      var token = await APICacheManager().getCacheData("login_token");
      var headers = {
        'Authorization': 'Bearer ${token.syncData}',
        'accept': 'application/json',
        'Content-Type': 'application/json',
      };

      var body = {
        "product_id": productId.toString(),
        "quantity": quantity,
        "variation_item_id": variation_item_id
      };

      var bodyJson = jsonEncode(body);

      var url = Uri.parse('$baseUrl/cart');

      var res = await http.patch(url, headers: headers, body: bodyJson);

      List<dynamic> jsonList = json.decode(res.body);
      cartItems = RxList<CartModel>(
          jsonList.map((jsonItem) => CartModel.fromJson(jsonItem)).toList());
// Reset values
      totalMRP.value = 0;
      totalDiscount.value = 0;
      for (var cartitem in cartItems) {
        cartitem.allVariationItems?.forEach((variationItem) {
          if (variationItem.variationItemId == cartitem.currentVariation) {
            totalMRP.value +=
                variationItem.regularPrice! * cartitem.quantity!.toInt();
            totalDiscount.value +=
                (variationItem.regularPrice! - variationItem.salePrice!) *
                    cartitem.quantity!.toInt();
          }
        });
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
