// controllers/metal_price_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/metal_price.dart';

class MetalPriceController extends GetxController {
  var prices = <MetalPrice>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPrices();
    super.onInit();
  }

  void fetchPrices() async {
    try {
      isLoading(true);
      var response =
          await http.get(Uri.parse('https://api.gehnamall.com/api/prices'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List;
        prices.value =
            jsonData.map((data) => MetalPrice.fromJson(data)).toList();
      }
    } catch (e) {
      print('Error fetching prices: $e');
    } finally {
      isLoading(false);
    }
  }
}
