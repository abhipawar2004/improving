import 'dart:convert';

OccasionCardModels occasionCardModelsFromJson(String str) =>
    OccasionCardModels.fromJson(json.decode(str));

String occasionCardModelsToJson(OccasionCardModels data) =>
    json.encode(data.toJson());

class OccasionCardModels {
  final int status;
  final String message;
  final int totalProducts;
  final List<OccasionCard> products;
  final dynamic productDetail;

  OccasionCardModels({
    required this.status,
    required this.message,
    required this.totalProducts,
    required this.products,
    required this.productDetail,
  });

  factory OccasionCardModels.fromJson(Map<String, dynamic> json) =>
      OccasionCardModels(
        status: json["status"],
        message: json["message"],
        totalProducts: json["totalProducts"],
        products: List<OccasionCard>.from(
            json["products"].map((x) => OccasionCard.fromJson(x))),
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

class OccasionCard {
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
  final String soulmateName;
  final String giftingName;
  final String occasion;
  final String soulmate;
  final String gifting;
  final int genderCode;
  final int tagNumber;
  final int size;
  final int length;
  final String wholeseller;
  final List<String> imageUrls;

  OccasionCard({
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
    this.genderCode = 0, // Default value
    this.tagNumber = 0, // Default value
    this.size = 0, // Default value
    this.length = 0, // Default value
    required this.wholeseller,
    required this.imageUrls,
  });

  factory OccasionCard.fromJson(Map<String, dynamic> json) => OccasionCard(
        productId: json["productId"] ?? 0, // Default value for non-nullable int
        productName: json["productName"] ?? "",
        categoryName: json["categoryName"] ?? "",
        subCategoryName: json["subCategoryName"] ?? "",
        price: json["price"],
        categoryCode: json["categoryCode"] ?? 0,
        subCategoryCode: json["subCategoryCode"] ?? 0,
        description: json["description"] ?? "",
        gender: json["gender"] ?? "",
        weight: json["weight"] ?? "",
        karat: json["karat"] ?? "",
        wastage: json["wastage"] ?? "",
        soulmateName: json["soulmateName"] ?? "",
        giftingName: json["giftingName"] ?? "",
        occasion: json["occasion"] ?? "",
        soulmate: json["soulmate"] ?? "",
        gifting: json["gifting"] ?? "",
        genderCode: json["genderCode"] ?? 0, // Default value
        tagNumber: json["tagNumber"] ?? 0, // Default value
        size: json["size"] ?? 0, // Default value
        length: json["length"] ?? 0, // Default value
        wholeseller: json["wholeseller"] ?? "",
        imageUrls: List<String>.from(json["imageUrls"].map((x) => x ?? "")),
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
