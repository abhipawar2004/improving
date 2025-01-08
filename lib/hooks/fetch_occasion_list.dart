import 'package:gehnamall/models/occasion/occasion_card_models.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class OccasionController extends GetxController {
  var isLoading = true.obs;
  var occasionCardModels = Rx<OccasionCardModels?>(null);
  var error = ''.obs;

  // Fetch the product data from the API
  Future<void> fetchProducts(String occasion, String wholeseller) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.gehnamall.com/api/getProducts?occasion=$occasion&wholeseller=$wholeseller'));
      if (response.statusCode == 200) {
        occasionCardModels.value = occasionCardModelsFromJson(response.body);
        isLoading.value = false;
      } else {
        error.value = 'Failed to load products';
        isLoading.value = false;
      }
    } catch (e) {
      error.value = 'Error: $e';
      isLoading.value = false;
    }
  }
}
