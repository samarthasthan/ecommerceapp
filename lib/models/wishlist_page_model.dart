class WishListModel {
  String? skuId;
  String? productId;
  String? productName;
  String? productImage;
  double? regularPrice;
  double? salePrice;
  List<Variations>? variations;

  WishListModel(
      {this.skuId,
      this.productId,
      this.productName,
      this.productImage,
      this.regularPrice,
      this.salePrice,
      this.variations});

  WishListModel.fromJson(Map<String, dynamic> json) {
    skuId = json['sku_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(new Variations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku_id'] = this.skuId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    if (this.variations != null) {
      data['variations'] = this.variations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variations {
  String? variationId;
  String? productId;
  String? variationName;
  List<VariationItems>? variationItems;

  Variations(
      {this.variationId,
      this.productId,
      this.variationName,
      this.variationItems});

  Variations.fromJson(Map<String, dynamic> json) {
    variationId = json['variation_id'];
    productId = json['product_id'];
    variationName = json['variation_name'];
    if (json['variation_items'] != null) {
      variationItems = <VariationItems>[];
      json['variation_items'].forEach((v) {
        variationItems!.add(new VariationItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variation_id'] = this.variationId;
    data['product_id'] = this.productId;
    data['variation_name'] = this.variationName;
    if (this.variationItems != null) {
      data['variation_items'] =
          this.variationItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariationItems {
  String? variationId;
  String? variationItemName;
  double? regularPrice;
  int? stock;
  String? variationItemId;
  double? salePrice;

  VariationItems(
      {this.variationId,
      this.variationItemName,
      this.regularPrice,
      this.stock,
      this.variationItemId,
      this.salePrice});

  VariationItems.fromJson(Map<String, dynamic> json) {
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
