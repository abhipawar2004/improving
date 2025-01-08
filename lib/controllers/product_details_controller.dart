// lib/controllers/product_details_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  var currentImageIndex = 0.obs;
  final PageController pageController = PageController();
}
