import 'package:get/get.dart';

class BannerController extends GetxController {
  var banner = ''.obs;
  var title = ''.obs;

  void updateBanner(String value) {
    banner.value = value;
  }

  void updateTitle(String value) {
    title.value = value;
  }
}
