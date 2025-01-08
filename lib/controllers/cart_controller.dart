import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartController extends GetxController {
  var cartItems = [].obs;
  var isLoading = false.obs;

  Future<void> addToCart(String userId, String productId) async {
    isLoading.value = true;
    final url = Uri.parse(
        'https://api.gehnamall.com/api/addToCart?userId=$userId&productId=$productId');
    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        fetchCartItems(userId);
        Get.snackbar(
          'Yay! 🎉',
          'Your item has been added to the cart 🛒. Happy shopping! 😊',
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 20.h),
          backgroundColor: const Color.fromARGB(255, 1, 80, 4),
          colorText: Colors.white, // Change text color here
        );
      } else {
        Get.snackbar(
          'Oops! 😓',
          'Failed to add item to cart. Please try again later. 🚫',
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 20.h),
          backgroundColor: Colors.red,
          colorText: Colors.white, // Change text color here
        );
      }
    } catch (e) {
      Get.snackbar(
        'Network Issue 🌐',
        'Oops! Something went wrong with the network: $e. Please try again. ⚠️',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.only(bottom: 20.h),
        backgroundColor: Colors.red,
        colorText: Colors.white, // Change text color here
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCartItems(String userId) async {
    isLoading.value = true;
    final url =
        Uri.parse('https://api.gehnamall.com/api/getCartItem?userId=$userId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        cartItems.value = data['enhancedProducts'] ?? [];
      } else {
        Get.snackbar(
          'Oops! 😓',
          'Failed to fetch cart items. Please try again. 🚫',
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 20.h),
          backgroundColor: Colors.red,
          colorText: Colors.white, // Change text color here
        );
      }
    } catch (e) {
      Get.snackbar(
        'Network Issue 🌐',
        'Oops! Something went wrong with the network: $e. Please try again. ⚠️',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.only(bottom: 20.h),
        backgroundColor: Colors.red,
        colorText: Colors.white, // Change text color here
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFromCart(String userId, String productId) async {
    isLoading.value = true;
    final url = Uri.parse(
        'https://api.gehnamall.com/api/removeFromCart?userId=$userId&productId=$productId');
    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        fetchCartItems(userId);
        Get.snackbar(
          'Success!',
          'Item has been removed from your cart 🛒. We’ll miss it! 😔',
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 20.h),
          backgroundColor: const Color.fromARGB(255, 1, 80, 4),
          colorText: Colors.white, // Change text color here
        );
      } else {
        Get.snackbar(
          'Oops! 😓',
          'Failed to remove item from cart. Please try again later. 🚫',
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 20.h),
          backgroundColor: Colors.red,
          colorText: Colors.white, // Change text color here
        );
      }
    } catch (e) {
      Get.snackbar(
        'Network Issue 🌐',
        'Oops! Something went wrong with the network: $e. Please try again. ⚠️',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.only(bottom: 20.h),
        backgroundColor: Colors.red,
        colorText: Colors.white, // Change text color here
      );
    } finally {
      isLoading.value = false;
    }
  }
}
