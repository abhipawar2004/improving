import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gehnamall/models/hook_models/hook_result.dart';
import 'package:gehnamall/models/soulmate/solemate_models.dart';
import '../models/api_error.dart';
import 'package:http/http.dart' as http;

FetchHook UseFetchSoulmate() {
  final SoulmateItems = useState<List<SoulmateModels>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('https://api.gehnamall.com/api/soulmate');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        SoulmateItems.value = soulmateModelsFromJson(response.body);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      if (e is Exception) {
        error.value = e; // Safely cast to Exception
      } else {
        error.value = Exception('An unknown error occurred');
      }
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
    data: SoulmateItems.value,
    isloading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
