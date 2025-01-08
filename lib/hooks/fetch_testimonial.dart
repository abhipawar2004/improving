import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gehnamall/models/hook_models/hook_result.dart';
import 'package:gehnamall/models/testimonial_models.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchTestimonial() {
  final testimonialItems = useState<List<TestimonialModels>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);

  // Async function to fetch data from the API.
  Future<void> fetchData() async {
    isLoading.value = true;
    error.value = null; // Reset the error before making the API call.

    try {
      final url = Uri.parse('https://api.gehnamall.com/api/testimonial');

      // Adding headers if needed (if the API requires them)
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        // Add other headers here if necessary
      });

      if (response.statusCode == 200) {
        testimonialItems.value = testimonialModelsFromJson(response.body);
      } else {
        throw Exception('Failed to load banners: ${response.statusCode}');
      }
    } on Exception catch (e) {
      error.value = e; // Store the error if an exception is thrown
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
    data: testimonialItems.value,
    isloading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
