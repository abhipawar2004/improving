import 'package:gehnamall/models/lightcategorycardModels.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class lightController extends GetxController {
  var isLoading = true.obs;
  var lightCardModels = Rx<LightCardModels?>(null);
  var error = ''.obs;

  // Fetch the product data from the API
  Future<void> fetchLightProducts(
      String categoryCode, String wholeseller) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.gehnamall.com/api/getProducts?categoryCode=$categoryCode&lightWeight=light&wholeseller=Bansal'));
      if (response.statusCode == 200) {
        lightCardModels.value = lightCardModelsFromJson(response.body);
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
