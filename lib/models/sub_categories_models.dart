import 'dart:convert';

List<SubCategoryModels> subCategoryModelsFromJson(String str) =>
    List<SubCategoryModels>.from(
        json.decode(str).map((x) => SubCategoryModels.fromJson(x)));

String subCategoryModelsToJson(List<SubCategoryModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategoryModels {
  final int subcategoryId;
  final String subcategoryName;
  final int subcategoryCode;
  final int categoryCode;
  final dynamic categoryName;
  final Description? description;
  final int price;
  final String exfield1;
  final String exfield2;
  final Gender? gender;
  final int genderCode;
  final DateTime createDate;
  final DateTime modiDate;
  final Wholeseller? wholeseller;

  SubCategoryModels({
    required this.subcategoryId,
    required this.subcategoryName,
    required this.subcategoryCode,
    required this.categoryCode,
    required this.categoryName,
    this.description,
    required this.price,
    required this.exfield1,
    required this.exfield2,
    this.gender,
    required this.genderCode,
    required this.createDate,
    required this.modiDate,
    this.wholeseller,
  });

  factory SubCategoryModels.fromJson(Map<String, dynamic> json) =>
      SubCategoryModels(
        subcategoryId: json["subcategoryId"],
        subcategoryName: json["subcategoryName"],
        subcategoryCode: json["subcategoryCode"],
        categoryCode: json["categoryCode"],
        categoryName: json["categoryName"],
        description: descriptionValues.map[json["description"]],
        price: json["price"],
        exfield1: json["exfield1"],
        exfield2: json["exfield2"],
        gender: genderValues.map[json["gender"]],
        genderCode: json["genderCode"],
        createDate: DateTime.parse(json["createDate"]),
        modiDate: DateTime.parse(json["modiDate"]),
        wholeseller: wholesellerValues.map[json["wholeseller"]],
      );

  Map<String, dynamic> toJson() => {
        "subcategoryId": subcategoryId,
        "subcategoryName": subcategoryName,
        "subcategoryCode": subcategoryCode,
        "categoryCode": categoryCode,
        "categoryName": categoryName,
        "description": descriptionValues.reverse[description],
        "price": price,
        "exfield1": exfield1,
        "exfield2": exfield2,
        "gender": genderValues.reverse[gender],
        "genderCode": genderCode,
        "createDate": createDate.toIso8601String(),
        "modiDate": modiDate.toIso8601String(),
        "wholeseller": wholesellerValues.reverse[wholeseller],
      };
}

enum Description { GOLD_FEMALE_SUBCATEGORY, GOLD_MENS_SUBCATEGORY }

final descriptionValues = EnumValues({
  "Gold Female subcategory": Description.GOLD_FEMALE_SUBCATEGORY,
  "Gold Mens subcategory": Description.GOLD_MENS_SUBCATEGORY
});

enum Gender { MEN, WOMEN }

final genderValues = EnumValues({
  "Men": Gender.MEN,
  "Women": Gender.WOMEN,
});

enum Wholeseller { BANSAL }

final wholesellerValues = EnumValues({
  "BANSAL": Wholeseller.BANSAL,
});

class EnumValues<T> {
  final Map<String, T> map;
  late final Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }

  /// Safely get enum value or return `null` for unknown keys
  T? safeGet(String? key) {
    if (key == null) return null;
    return map[key];
  }
}
