import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SKUModel {
  String? skuId;
  List<Products>? products;

  SKUModel({this.skuId, this.products});

  SKUModel.fromJson(Map<String, dynamic> json) {
    skuId = json['sku_id'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku_id'] = this.skuId;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? productId;
  String? productName;
  String? productDescription;
  String? color;
  String? colorHex;
  Rx<bool>? inCart;
  Rx<bool>? inWishlist;
  List<ProductDetails>? productDetails;
  List<ProductImages>? productImages;
  List<Variations>? variations;

  Products(
      {this.productId,
      this.productName,
      this.productDescription,
      this.color,
      this.colorHex,
      this.inCart,
      this.inWishlist,
      this.productDetails,
      this.productImages,
      this.variations});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    color = json['color'];
    colorHex = json['color_hex'];
    inCart = RxBool(json['in_cart'] ?? false); // Initialize as RxBool
    inWishlist = RxBool(json['in_wishlist'] ?? false); // Initialize as RxBool
    if (json['product_details'] != null) {
      productDetails = <ProductDetails>[];
      json['product_details'].forEach((v) {
        productDetails!.add(new ProductDetails.fromJson(v));
      });
    }
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(new Variations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    data['color'] = this.color;
    data['color_hex'] = this.colorHex;
    data['in_cart'] = this.inCart;
    data['in_wishlist'] = this.inWishlist;
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails!.map((v) => v.toJson()).toList();
    }
    if (this.productImages != null) {
      data['product_images'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    if (this.variations != null) {
      data['variations'] = this.variations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetails {
  String? detailId;
  String? heading;
  List<BulletPoints>? bulletPoints;

  ProductDetails({this.detailId, this.heading, this.bulletPoints});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    detailId = json['detail_id'];
    heading = json['heading'];
    if (json['bullet_points'] != null) {
      bulletPoints = <BulletPoints>[];
      json['bullet_points'].forEach((v) {
        bulletPoints!.add(new BulletPoints.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detail_id'] = this.detailId;
    data['heading'] = this.heading;
    if (this.bulletPoints != null) {
      data['bullet_points'] =
          this.bulletPoints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BulletPoints {
  String? bulletId;
  String? point;

  BulletPoints({this.bulletId, this.point});

  BulletPoints.fromJson(Map<String, dynamic> json) {
    bulletId = json['bullet_id'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bullet_id'] = this.bulletId;
    data['point'] = this.point;
    return data;
  }
}

class ProductImages {
  String? imageId;
  String? smallImageUrl;
  String? mediumImageUrl;
  String? largeImageUrl;

  ProductImages(
      {this.imageId,
      this.smallImageUrl,
      this.mediumImageUrl,
      this.largeImageUrl});

  ProductImages.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    smallImageUrl = json['small_image_url'];
    mediumImageUrl = json['medium_image_url'];
    largeImageUrl = json['large_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_id'] = this.imageId;
    data['small_image_url'] = this.smallImageUrl;
    data['medium_image_url'] = this.mediumImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    return data;
  }
}

class Variations {
  String? variationId;
  String? variationName;
  List<VariationItems>? variationItems;

  Variations({this.variationId, this.variationName, this.variationItems});

  Variations.fromJson(Map<String, dynamic> json) {
    variationId = json['variation_id'];
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
    data['variation_name'] = this.variationName;
    if (this.variationItems != null) {
      data['variation_items'] =
          this.variationItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariationItems {
  String? variationItemId;
  String? variationItemName;
  int? stock;
  double? regularPrice;
  double? salePrice;

  VariationItems(
      {this.variationItemId,
      this.variationItemName,
      this.stock,
      this.regularPrice,
      this.salePrice});

  VariationItems.fromJson(Map<String, dynamic> json) {
    variationItemId = json['variation_item_id'];
    variationItemName = json['variation_item_name'];
    stock = json['stock'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variation_item_id'] = this.variationItemId;
    data['variation_item_name'] = this.variationItemName;
    data['stock'] = this.stock;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    return data;
  }
}
