//lib\models\product_card_models.dart

import 'dart:convert';

import 'package:gehnamall/models/base_product.dart';

ProductCardModels productCardModelsFromJson(String str) =>
    ProductCardModels.fromJson(json.decode(str));

String productCardModelsToJson(ProductCardModels data) =>
    json.encode(data.toJson());

class ProductCardModels {
  final int status;
  final String message;
  final int totalProducts;
  final List<Product> products;
  final dynamic productDetail;

  ProductCardModels({
    required this.status,
    required this.message,
    required this.totalProducts,
    required this.products,
    required this.productDetail,
  });

  factory ProductCardModels.fromJson(Map<String, dynamic> json) =>
      ProductCardModels(
        status: json["status"],
        message: json["message"],
        totalProducts: json["totalProducts"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        productDetail: json["productDetail"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "totalProducts": totalProducts,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "productDetail": productDetail,
      };
}

class Product implements BaseProduct {
  final int productId;
  final String productName;
  final String categoryName;
  final String subCategoryName;
  final dynamic price;
  final int categoryCode;
  final int subCategoryCode;
  final String description;
  final dynamic gender;
  final String weight;
  final String karat;
  final String wastage;
  final dynamic soulmateName;
  final dynamic giftingName;
  final dynamic occasion;
  final dynamic soulmate;
  final dynamic gifting;
  final int genderCode;
  final dynamic tagNumber;
  final dynamic size;
  final dynamic length;
  final String wholeseller;
  final List<String> imageUrls;

  Product({
    required this.productId,
    required this.productName,
    required this.categoryName,
    required this.subCategoryName,
    required this.price,
    required this.categoryCode,
    required this.subCategoryCode,
    required this.description,
    required this.gender,
    required this.weight,
    required this.karat,
    required this.wastage,
    required this.soulmateName,
    required this.giftingName,
    required this.occasion,
    required this.soulmate,
    required this.gifting,
    required this.genderCode,
    required this.tagNumber,
    required this.size,
    required this.length,
    required this.wholeseller,
    required this.imageUrls,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        productName: json["productName"],
        categoryName: json["categoryName"],
        subCategoryName: json["subCategoryName"],
        price: json["price"],
        categoryCode: json["categoryCode"],
        subCategoryCode: json["subCategoryCode"],
        description: json["description"],
        gender: json["gender"],
        weight: json["weight"],
        karat: json["karat"],
        wastage: json["wastage"],
        soulmateName: json["soulmateName"],
        giftingName: json["giftingName"],
        occasion: json["occasion"],
        soulmate: json["soulmate"],
        gifting: json["gifting"],
        genderCode: json["genderCode"],
        tagNumber: json["tagNumber"],
        size: json["size"],
        length: json["length"],
        wholeseller: json["wholeseller"],
        imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "categoryName": categoryName,
        "subCategoryName": subCategoryName,
        "price": price,
        "categoryCode": categoryCode,
        "subCategoryCode": subCategoryCode,
        "description": description,
        "gender": gender,
        "weight": weight,
        "karat": karat,
        "wastage": wastage,
        "soulmateName": soulmateName,
        "giftingName": giftingName,
        "occasion": occasion,
        "soulmate": soulmate,
        "gifting": gifting,
        "genderCode": genderCode,
        "tagNumber": tagNumber,
        "size": size,
        "length": length,
        "wholeseller": wholeseller,
        "imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
      };
}
