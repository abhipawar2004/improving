import 'dart:convert';

List<TestimonialModels> testimonialModelsFromJson(String str) =>
    List<TestimonialModels>.from(
        json.decode(str).map((x) => TestimonialModels.fromJson(x)));

String testimonialModelsToJson(List<TestimonialModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestimonialModels {
  final int testimonialId;
  final String customerName;
  final String customerDesignation;
  final String testimonialText;
  final int rating;
  final String imageUrl;
  final bool status;
  final String exfield1;
  final String exfield2;
  final DateTime createDate;
  final DateTime modiDate;

  TestimonialModels({
    required this.testimonialId,
    required this.customerName,
    required this.customerDesignation,
    required this.testimonialText,
    required this.rating,
    required this.imageUrl,
    required this.status,
    required this.exfield1,
    required this.exfield2,
    required this.createDate,
    required this.modiDate,
  });

  factory TestimonialModels.fromJson(Map<String, dynamic> json) =>
      TestimonialModels(
        testimonialId: json["testimonialId"] != null
            ? json["testimonialId"] as int
            : 0, // Ensure testimonialId is an integer, default to 0 if null
        customerName:
            json["customerName"] ?? '', // Provide default value if null
        customerDesignation:
            json["customerDesignation"] ?? '', // Provide default value if null
        testimonialText:
            json["testimonialText"] ?? '', // Provide default value if null
        rating: json["rating"] ??
            0, // Provide default value if null (assuming it's an int)
        imageUrl: json["imageUrl"] ?? '', // Provide default value if null
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
        "testimonialId": testimonialId,
        "customerName": customerName,
        "customerDesignation": customerDesignation,
        "testimonialText": testimonialText,
        "rating": rating,
        "imageUrl": imageUrl,
        "status": status,
        "exfield1": exfield1,
        "exfield2": exfield2,
        "createDate": createDate.toIso8601String(),
        "modiDate": modiDate.toIso8601String(),
      };
}
