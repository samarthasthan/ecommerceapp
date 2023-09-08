class ProductsModel {
  String? skuId;
  String? productId;
  String? productName;
  String? productImage;
  double? regularPrice;
  double? salePrice;

  ProductsModel(
      {this.skuId,
      this.productId,
      this.productName,
      this.productImage,
      this.regularPrice,
      this.salePrice});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    skuId = json['sku_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku_id'] = this.skuId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    return data;
  }
}
