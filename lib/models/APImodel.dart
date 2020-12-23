import 'dart:convert';

ProductDetails productDetailsFromJson(String str) => ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  ProductDetails({
    this.code,
    this.status,
    this.statusVerbose,
    this.product,
  });

  String code;
  int status;
  String statusVerbose;
  Product product;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    code: json["code"] == null ? null : json["code"],
    status: json["status"] == null ? null : json["status"],
    statusVerbose: json["status_verbose"] == null ? null : json["status_verbose"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "status": status == null ? null : status,
    "status_verbose": statusVerbose == null ? null : statusVerbose,
    "product": product == null ? null : product.toJson(),
  };
}

class Product {
  Product({
    this.productName,
    this.ingredientsTextEn,
    this.imageUrl,
  });

  String productName;
  String ingredientsTextEn;
  String imageUrl;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productName: json["product_name"] == null ? null : json["product_name"],
    ingredientsTextEn: json["ingredients_text_en"] == null ? null : json["ingredients_text_en"],
    imageUrl: json["image_url"] == null ? null : json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "product_name": productName == null ? null : productName,
    "ingredients_text_en": ingredientsTextEn == null ? null : ingredientsTextEn,
    "image_url": imageUrl == null ? null : imageUrl,
  };
}
