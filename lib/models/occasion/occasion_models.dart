import 'dart:convert';

List<OccasionModels> occasionModelsFromJson(String str) =>
    List<OccasionModels>.from(
        json.decode(str).map((x) => OccasionModels.fromJson(x)));

String occasionModelsToJson(List<OccasionModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OccasionModels {
  final int giftingId;
  final String giftingName;
  final int giftingCode;
  final String description;
  final int price;
  final String exfield1;
  final String exfield2;
  final DateTime createDate;
  final DateTime modiDate;

  OccasionModels({
    required this.giftingId,
    required this.giftingName,
    required this.giftingCode,
    required this.description,
    required this.price,
    required this.exfield1,
    required this.exfield2,
    required this.createDate,
    required this.modiDate,
  });

  factory OccasionModels.fromJson(Map<String, dynamic> json) => OccasionModels(
        giftingId: json["giftingId"],
        giftingName: json["giftingName"],
        giftingCode: json["giftingCode"],
        description: json["description"],
        price: json["price"],
        exfield1: json["exfield1"],
        exfield2: json["exfield2"],
        createDate: DateTime.parse(json["createDate"]),
        modiDate: DateTime.parse(json["modiDate"]),
      );

  Map<String, dynamic> toJson() => {
        "giftingId": giftingId,
        "giftingName": giftingName,
        "giftingCode": giftingCode,
        "description": description,
        "price": price,
        "exfield1": exfield1,
        "exfield2": exfield2,
        "createDate": createDate.toIso8601String(),
        "modiDate": modiDate.toIso8601String(),
      };
}
