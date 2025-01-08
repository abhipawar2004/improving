import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gehnamall/models/hook_models/hook_result.dart';
import 'package:http/http.dart' as http;
import '../models/banner_models.dart';

FetchHook useFetchBanner() {
  // State variables to hold the banners, loading state, and error.
  final banners = useState<List<BannerModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);

  // Async function to fetch data from the API.
  Future<void> fetchData() async {
    isLoading.value = true;
    error.value = null; // Reset the error before making the API call.

    try {
      final url = Uri.parse('https://api.gehnamall.com/api/banners');

      // Adding headers if needed (if the API requires them)
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        // Add other headers here if necessary
      });

      if (response.statusCode == 200) {
        banners.value = bannerModelFromJson(response.body);
      } else {
        throw Exception('Failed to load banners: ${response.statusCode}');
      }
    } on Exception catch (e) {
      error.value = e; // Store the error if an exception is thrown
    } finally {
      isLoading.value = false;
    }
  }

  // The useEffect hook runs when the widget is first created or when dependencies change.
  useEffect(() {
    fetchData();
    return null;
  }, []); // Empty list ensures this effect runs only once.

  // Return the state encapsulated in the FetchHook class.
  return FetchHook(
    data: banners.value,
    isloading: isLoading.value,
    error: error.value,
    refetch: fetchData,
  );
}
