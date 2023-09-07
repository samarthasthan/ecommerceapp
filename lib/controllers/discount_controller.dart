int discountCalulator(double salePrice, double regularPrice) {
  var discount = ((regularPrice - salePrice) / regularPrice) * 100;
  return discount.toInt();
}
