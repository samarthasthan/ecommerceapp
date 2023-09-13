class ProductsModel {
  String? skuId;
  String? productId;
  String? productName;
  String? productImage;
  double? regularPrice;
  double? salePrice;
  bool? inCart;
  bool? inWishlist;

  ProductsModel(
      {this.skuId,
      this.productId,
      this.productName,
      this.productImage,
      this.regularPrice,
      this.salePrice,
      this.inCart,
      this.inWishlist});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    skuId = json['sku_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    inCart = json['in_cart'];
    inWishlist = json['in_wishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku_id'] = this.skuId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['in_cart'] = this.inCart;
    data['in_wishlist'] = this.inWishlist;
    return data;
  }
}
