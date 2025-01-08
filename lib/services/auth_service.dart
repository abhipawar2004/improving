import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Sign-Up Function
  static Future<Map<String, dynamic>> signUp(
      String phoneNumber, String name) async {
    final url = Uri.parse(
        'https://api.gehnamall.com/auth/register?phoneNumber=$phoneNumber&name=$name');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phoneNumber': phoneNumber, 'name': name}),
      );
      print('Signup response: ${response.body}');
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'data': data};
      }
    } catch (e) {
      print('Signup error: $e');
      return {
        'success': false,
        'data': {'message': 'Network error occurred'}
      };
    }
  }

  /// Login Function
  static Future<Map<String, dynamic>> login(String phoneNumber) async {
    final url = Uri.parse(
        'https://api.gehnamall.com/auth/login?phoneNumber=$phoneNumber');
    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else if (response.statusCode == 404) {
        return {
          'success': false,
          'data': {'message': 'User not registered'},
        };
      } else {
        return {'success': false, 'data': data};
      }
    } catch (e) {
      return {
        'success': false,
        'data': {'message': 'Network error occurred'},
      };
    }
  }

  /// OTP Verification Function

  static Future<Map<String, dynamic>> verifyOtp(
      String phoneNumber, String otp) async {
    final url = Uri.parse(
        'https://api.gehnamall.com/auth/otpVerify?phoneNumber=$phoneNumber&otp=$otp');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phoneNumber': phoneNumber, 'otp': otp}),
      );

      print('Response Body: ${response.body}');
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final prefs = await SharedPreferences.getInstance();

        // Save login state
        prefs.setBool('isLoggedIn', true);

        // Save userId if it exists
        if (data.containsKey('userId') && data['userId'] != null) {
          prefs.setString('userId', data['userId'].toString());
        }

        return {'success': true, 'data': data};
      } else {
        print('Error: Non-200 status code received: ${response.statusCode}');
        return {'success': false, 'data': json.decode(response.body)};
      }
    } catch (e) {
      print('Exception occurred: $e');
      return {
        'success': false,
        'data': {'message': 'Network error occurred: $e'}
      };
    }
  }

  // Check if user is logged in
  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false; // Defaults to false if not set
  }

  // Logout function
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    // Clear specific keys related to user session and profile
    // await prefs.remove('isLoggedIn');
    // await prefs.remove('phoneNumber');
    // await prefs.remove('userId');
    // await prefs.remove('email'); // Add any other keys you use
    // await prefs.remove('gender');
    // await prefs.remove('address');
    // await prefs.remove('pinCode');
    // await prefs.remove('birthDate');
    // await prefs.remove('spouseDate');

    // Optional: Clear all stored data if you want
    await prefs.clear();

    print("Logout successful. All relevant data cleared.");
  }

  /// Fetch User ID from SharedPreferences
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId'); // Returns null if userId is not found
  }

  static Future<bool> updateUserDetails(
      String userId, Map<String, String> updatedDetails) async {
    final url = Uri.parse('https://api.gehnamall.com/auth/updateUser/$userId');

    try {
      print("Request URL: $url");
      print("Request Data: $updatedDetails");

      // Create a multipart request
      final request = http.MultipartRequest('POST', url);

      // Add fields to the form-data
      updatedDetails.forEach((key, value) {
        request.fields[key] = value;
      });

      // Send the request
      final response = await request.send();

      // Parse the response
      final responseBody = await response.stream.bytesToString();
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: $responseBody");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseBody);
        final status = jsonResponse['status'];
        final message = jsonResponse['message'];

        if (status == 0) {
          print('Update successful: $message');
          return true;
        } else {
          print('Update failed: $message');
          return false;
        }
      } else {
        print('Failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error occurred during update: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>> getUserDetails(String userId) async {
    final url =
        Uri.parse('https://api.gehnamall.com/auth/getUserDetail/$userId');
    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'data': data};
      }
    } catch (e) {
      return {
        'success': false,
        'data': {'message': 'Network error occurred'},
      };
    }
  }

  static Future<bool> uploadImageToServer(String userId, File image) async {
    try {
      // Example HTTP request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.gehnamall.com/auth/updateUser/$userId'),
      );
      request.fields['userId'] = userId;
      request.files
          .add(await http.MultipartFile.fromPath('profileImage', image.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        return true; // Success
      } else {
        return false; // Failure
      }
    } catch (e) {
      print('Error uploading image: $e');
      return false; // Error occurred
    }
  }
}
