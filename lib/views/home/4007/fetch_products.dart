// fetch_products.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  final int productId;
  final String productName;
  final String categoryName;
  final String subCategoryName;
  final dynamic price;
  final int categoryCode;
  final dynamic subCategoryCode;
  final String description;
  final dynamic gender;
  final String weight;
  final String karat;
  final String wastage;
  final String soulmateName;
  final String giftingName;
  final String occasion;
  final String soulmate;
  final String gifting;
  final int genderCode;
  final dynamic tagNumber;
  final dynamic size;
  final dynamic length;
  final String wholeseller;
  final List<String> imageUrls;
  final dynamic exField1;
  final dynamic exField2;

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
    required this.exField1,
    required this.exField2,
  });

  Product copyWith({
    int? productId,
    String? productName,
    String? categoryName,
    String? subCategoryName,
    dynamic price,
    int? categoryCode,
    dynamic subCategoryCode,
    String? description,
    dynamic gender,
    String? weight,
    String? karat,
    String? wastage,
    String? soulmateName,
    String? giftingName,
    String? occasion,
    String? soulmate,
    String? gifting,
    int? genderCode,
    dynamic tagNumber,
    dynamic size,
    dynamic length,
    String? wholeseller,
    List<String>? imageUrls,
    dynamic exField1,
    dynamic exField2,
  }) =>
      Product(
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        categoryName: categoryName ?? this.categoryName,
        subCategoryName: subCategoryName ?? this.subCategoryName,
        price: price ?? this.price,
        categoryCode: categoryCode ?? this.categoryCode,
        subCategoryCode: subCategoryCode ?? this.subCategoryCode,
        description: description ?? this.description,
        gender: gender ?? this.gender,
        weight: weight ?? this.weight,
        karat: karat ?? this.karat,
        wastage: wastage ?? this.wastage,
        soulmateName: soulmateName ?? this.soulmateName,
        giftingName: giftingName ?? this.giftingName,
        occasion: occasion ?? this.occasion,
        soulmate: soulmate ?? this.soulmate,
        gifting: gifting ?? this.gifting,
        genderCode: genderCode ?? this.genderCode,
        tagNumber: tagNumber ?? this.tagNumber,
        size: size ?? this.size,
        length: length ?? this.length,
        wholeseller: wholeseller ?? this.wholeseller,
        imageUrls: imageUrls ?? this.imageUrls,
        exField1: exField1 ?? this.exField1,
        exField2: exField2 ?? this.exField2,
      );

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
        exField1: json["exField1"],
        exField2: json["exField2"],
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
        "exField1": exField1,
        "exField2": exField2,
      };
}

Future<List<Product>> fetchProducts(int categoryCode) async {
  final url = Uri.parse(
      'https://api.gehnamall.com/api/getProducts?wholeseller=BANSAL&categoryCode=$categoryCode');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['status'] == 0 && data['products'] != null) {
      return List<Product>.from(
        data['products'].map((product) => Product.fromJson(product)),
      );
    } else {
      throw Exception(data['message'] ?? 'Failed to fetch products');
    }
  } else {
    throw Exception('Failed to connect to the server');
  }
}
