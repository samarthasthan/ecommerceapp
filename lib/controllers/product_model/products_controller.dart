import 'dart:convert';

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/models/product_models/product_model.dart';
import 'package:ecommerceapp/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductsController extends GetxController {
  RxList<ProductsModel> productsListItems = RxList<ProductsModel>.empty();
  RxBool isLoading = false.obs;
  RxBool noMoreItems = false.obs;
  final RxInt currentPage = 1.obs;
  Future<void> getProductsListPage() async {
    if (isLoading.value) {
      return; // Avoid making multiple requests simultaneously
    }

    isLoading.value = true;
    UserModel userDetails = await getUserDetails();
    var url = Uri.parse(
        '$baseUrl/products?user_id=${userDetails.userId}&category_id=$categoryId&page=${currentPage.value}&per_page=10');

    try {
      var res = await http.get(url);

      if (res.statusCode == 200) {
        List<dynamic> jsonList = json.decode(res.body);
        if (jsonList.isEmpty) {
          noMoreItems.value = true; // Set to true when there are no more items
          return;
        }
        List<ProductsModel> newItems = jsonList
            .map((jsonItem) => ProductsModel.fromJson(jsonItem))
            .toList();

        // Append the new items to the list
        productsListItems.addAll(newItems);
        currentPage.value++; // Increment the current page
      } else {
        throw Exception('http.get error: statusCode= ${res.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
