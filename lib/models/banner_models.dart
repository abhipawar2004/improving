import 'dart:convert';

List<BannerModel> bannerModelFromJson(String str) => List<BannerModel>.from(
    json.decode(str).map((x) => BannerModel.fromJson(x)));

String bannerModelToJson(List<BannerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerModel {
  final int bannerId;
  final String bannerName;
  final String bannerCategory;
  final String bannerSubcategory;
  final String imageUrl;
  final String linkUrl;
  final String description;
  final bool status;
  final String exfield1;
  final String exfield2;
  final DateTime createDate;
  final DateTime modiDate;

  BannerModel({
    required this.bannerId,
    required this.bannerName,
    required this.bannerCategory,
    required this.bannerSubcategory,
    required this.imageUrl,
    required this.linkUrl,
    required this.description,
    required this.status,
    required this.exfield1,
    required this.exfield2,
    required this.createDate,
    required this.modiDate,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        bannerId: json["bannerId"],
        bannerName: json["bannerName"] ?? '', // Provide default value if null
        bannerCategory:
            json["bannerCategory"] ?? '', // Provide default value if null
        bannerSubcategory:
            json["bannerSubcategory"] ?? '', // Provide default value if null
        imageUrl: json["imageUrl"] ?? '', // Provide default value if null
        linkUrl: json["linkUrl"] ?? '', // Provide default value if null
        description: json["description"] ?? '', // Provide default value if null
        status: json["status"] ??
            false, // Handle boolean values, provide default if null
        exfield1: json["exfield1"] ?? '', // Provide default value if null
        exfield2: json["exfield2"] ?? '', // Provide default value if null
        createDate: json["createDate"] != null
            ? DateTime.parse(json["createDate"])
            : DateTime.now(),
        modiDate: json["modiDate"] != null
            ? DateTime.parse(json["modiDate"])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        //can clear this
        "bannerId": bannerId,
        "bannerName": bannerName,
        "bannerCategory": bannerCategory,
        "bannerSubcategory": bannerSubcategory,
        "imageUrl": imageUrl,
        "linkUrl": linkUrl,
        "description": description,
        "status": status,
        "exfield1": exfield1,
        "exfield2": exfield2,
        "createDate": createDate.toIso8601String(),
        "modiDate": modiDate.toIso8601String(),
      };
}
