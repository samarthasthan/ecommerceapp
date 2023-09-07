class CartModel {
  String? cartId;
  String? skuID;
  String? productId;
  String? productName;
  String? productImage;
  int? quantity;
  String? currentVariation;
  List<AllVariationItems>? allVariationItems;

  CartModel(
      {this.cartId,
      this.skuID,
      this.productId,
      this.productName,
      this.productImage,
      this.quantity,
      this.currentVariation,
      this.allVariationItems});

  CartModel.fromJson(Map<String, dynamic> json) {
    cartId = json['card_id'];
    skuID = json['sku_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    quantity = json['quantity'];
    currentVariation = json['current_variation'];
    if (json['all_variation_items'] != null) {
      allVariationItems = <AllVariationItems>[];
      json['all_variation_items'].forEach((v) {
        allVariationItems!.add(new AllVariationItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_id'] = this.cartId;
    data['sku_id'] = this.skuID;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['quantity'] = this.quantity;
    data['current_variation'] = this.currentVariation;
    if (this.allVariationItems != null) {
      data['all_variation_items'] =
          this.allVariationItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllVariationItems {
  String? variationId;
  String? variationItemName;
  double? regularPrice;
  int? stock;
  String? variationItemId;
  double? salePrice;

  AllVariationItems(
      {this.variationId,
      this.variationItemName,
      this.regularPrice,
      this.stock,
      this.variationItemId,
      this.salePrice});

  AllVariationItems.fromJson(Map<String, dynamic> json) {
    variationId = json['variation_id'];
    variationItemName = json['variation_item_name'];
    regularPrice = json['regular_price'];
    stock = json['stock'];
    variationItemId = json['variation_item_id'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variation_id'] = this.variationId;
    data['variation_item_name'] = this.variationItemName;
    data['regular_price'] = this.regularPrice;
    data['stock'] = this.stock;
    data['variation_item_id'] = this.variationItemId;
    data['sale_price'] = this.salePrice;
    return data;
  }
}
