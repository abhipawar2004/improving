// models/metal_price.dart
class MetalPrice {
  final String metalName;
  final String price24K;
  final String price22K;
  final String price18K;
  final String price14K;

  MetalPrice({
    required this.metalName,
    required this.price24K,
    required this.price22K,
    required this.price18K,
    required this.price14K,
  });

  factory MetalPrice.fromJson(Map<String, dynamic> json) {
    return MetalPrice(
      metalName: json['metalName'],
      price24K: json['24K:'],
      price22K: json['22K:'],
      price18K: json['18K:'],
      price14K: json['14K:'],
    );
  }
}
