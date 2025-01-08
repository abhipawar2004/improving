import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/banner_controller.dart';
import '../../../models/banner_models.dart';

class BannerWidget extends StatelessWidget {
  final BannerModel banner;

  BannerWidget({required this.banner});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double designWidth = 375;
    double designHeight = 825;
    double widthFactor = screenWidth / designWidth;
    double heightFactor = screenHeight / designHeight;

    return Obx(
      () => GestureDetector(
        onTap: () => controller.banner.value = banner.bannerId.toString(),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 8 * widthFactor, // Adjusting for screen width
            vertical: 4 * heightFactor, // Adjusting for screen height
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Overlapping container background color
              Container(
                height: 200 *
                    heightFactor, // Adjusting height for different screen sizes
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.3), // Background color
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
              ),
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(15), // Rounded corners for the image
                child: CachedNetworkImage(
                  imageUrl: banner.imageUrl,
                  height: 200 *
                      heightFactor, // Adjusting height for different screen sizes
                  width: double.infinity,
                  fit: BoxFit
                      .cover, // Ensures the image covers the available space
                ),
              ),
              if (controller.banner.value == banner.bannerId)
                Positioned(
                  bottom: 20 *
                      heightFactor, // Adjust bottom padding for different screens
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          16 * widthFactor, // Adjusting for screen width
                      vertical: 8 * heightFactor, // Adjusting for screen height
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Selected',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
