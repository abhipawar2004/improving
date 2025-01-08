import 'package:gehnamall/models/occasion/occasion_card_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OccasionGiftingController extends GetxController {
  var isLoading = true.obs;
  var giftingCardModels = Rx<OccasionCardModels?>(null);
  var error = ''.obs;

  // Fetch the product data from the API
  Future<void> fetchGiftingProducts(
      String giftingName, String wholeseller) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.gehnamall.com/api/getProducts?gifting=$giftingName&wholeseller=$wholeseller'));
      if (response.statusCode == 200) {
        giftingCardModels.value = occasionCardModelsFromJson(response.body);
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
