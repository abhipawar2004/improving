import 'package:get/get.dart';

class AppBarController extends GetxController {
  // Observable for menu visibility
  var isMenuVisible = false.obs;

  // Toggle menu visibility
  void toggleMenu() {
    isMenuVisible.value = !isMenuVisible.value;
  }
}
