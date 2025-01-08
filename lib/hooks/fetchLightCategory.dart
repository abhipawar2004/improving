import 'package:gehnamall/models/hook_models/hook_result.dart';
import 'package:gehnamall/models/light_category_models.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../models/api_error.dart';
import 'package:http/http.dart' as http;

FetchHook UseFetchLightCategories() {
  final LightCategoriesItems = useState<List<LightCategoryModels>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse(
          'https://api.gehnamall.com/api/lightCategories?wholeseller=bansal');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        LightCategoriesItems.value = lightCategoryModelsFromJson(response.body);
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
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: LightCategoriesItems.value,
    isloading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
