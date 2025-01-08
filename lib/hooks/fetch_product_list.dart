import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gehnamall/models/hook_models/hook_result.dart';
import 'package:gehnamall/models/product_card_models.dart';
import '../models/api_error.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchProductList(
    String wholeseller, int categoryCode, int subCategoryCode) {
  final productList = useState<List<Product>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse(
          'https://api.gehnamall.com/api/getProducts?wholeseller=$wholeseller&categoryCode=$categoryCode&subCategoryCode=$subCategoryCode');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = productCardModelsFromJson(response.body);
        productList.value = data.products;
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      error.value = e as Exception;
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, [wholeseller, categoryCode, subCategoryCode]);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: productList.value,
    isloading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
