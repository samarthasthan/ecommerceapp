import 'dart:convert';

import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/models/sku_page_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SKUController extends GetxController {
  var skuItem = Rx<SKUModel?>(null);

  RxInt currentProduct = 0.obs;

  RxInt currentVariation = 0.obs;

  int getProductIndex(String productId) {
    for (var product in skuItem.value!.products!) {
      if (product.productId == productId) {
        currentProduct.value = skuItem.value!.products!.indexOf(product);
        return skuItem.value!.products!.indexOf(product);
      }
    }
    return 0;
  }

  int getProductVariationIndex(String variationItemName) {
    for (var variation in skuItem.value!.products![currentProduct.value]
        .variations![0].variationItems!) {
      if (variation.variationItemName == variationItemName) {
        currentVariation.value = skuItem.value!.products![currentProduct.value]
            .variations![0].variationItems!
            .indexOf(variation);
        return skuItem.value!.products![currentProduct.value].variations![0]
            .variationItems!
            .indexOf(variation);
      }
    }
    return 0;
  }

  Future<Rx<SKUModel?>> getSKUPage(String skuId) async {
    var headers = {
      'accept': 'application/json',
    };

    var url = Uri.parse('$baseUrl/product?sku_id=$skuId');
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    skuItem.value = SKUModel.fromJson(json.decode(res.body));
    return skuItem;
  }
}
