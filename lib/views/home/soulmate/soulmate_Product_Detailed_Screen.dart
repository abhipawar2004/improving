import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gehnamall/common/custom_button.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/controllers/cart_controller.dart';
import 'package:gehnamall/controllers/product_details_controller.dart';
import 'package:gehnamall/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:gehnamall/models/occasion/occasion_card_models.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SoulmateProductDetailedScreen extends StatelessWidget {
  final OccasionCard product;
  final cartController = Get.put(CartController());
  final ProductDetailsController controller =
      Get.put(ProductDetailsController());

  SoulmateProductDetailedScreen({Key? key, required this.product})
      : super(key: key);

  Future<String> getUserId() async {
    final userId = await AuthService.getUserId();
    return userId ?? 'Unknown';
  }

  // Launch a URL or perform a specific action
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url); // Ensure the URL is parsed as Uri
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri); // Use launchUrl instead of launch
    } else {
      Get.snackbar(
        'Error',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error retrieving user ID.'));
        }

        final userId = snapshot.data ?? 'Unknown';

        return Scaffold(
          appBar: AppBar(
            title: Text(
              product.categoryName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.sp, // Use ScreenUtil for font size
                color: Colors.white, // Set the text color
                letterSpacing: 1.2, // Add spacing between letters
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(2.0, 2.0),
                  ),
                ], // Add a subtle shadow effect to the text
              ),
            ),
            centerTitle: true,
            backgroundColor: kDark,
            automaticallyImplyLeading: false, // Hides the back arrow
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Horizontal Image Slider
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          12.r), // Use ScreenUtil for radius
                      child: SizedBox(
                        height: 420.h, // Use ScreenUtil for height
                        child: PageView.builder(
                          controller: controller.pageController,
                          onPageChanged: (index) =>
                              controller.currentImageIndex.value = index,
                          itemCount: product.imageUrls.length,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: product.imageUrls[index],
                              height: 220.h, // Use ScreenUtil for height
                              fit: BoxFit.cover,
                              errorWidget: (context, error, stackTrace) => Icon(
                                  Icons.broken_image,
                                  size: 220.h), // Use ScreenUtil for size
                            );
                          },
                        ),
                      ),
                    ),
                    Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            List.generate(product.imageUrls.length, (index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 8.h), // Use ScreenUtil for margin
                            width: controller.currentImageIndex.value == index
                                ? 12.w // Use ScreenUtil for width
                                : 8.w, // Use ScreenUtil for width
                            height: controller.currentImageIndex.value == index
                                ? 12.h // Use ScreenUtil for height
                                : 8.h, // Use ScreenUtil for height
                            decoration: BoxDecoration(
                              color: controller.currentImageIndex.value == index
                                  ? Colors.blue
                                  : Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                          );
                        }))),
                  ],
                ),
                SizedBox(height: 16.h),

                // Product Name
                Center(
                  child: Text(
                    product.productName,
                    style: TextStyle(
                      fontSize: 28.sp, // Use ScreenUtil for font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Product Details
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.r), // Use ScreenUtil for radius
                  ),
                  elevation: 4,
                  margin: EdgeInsets.symmetric(
                      vertical: 8.h), // Use ScreenUtil for margin
                  child: Padding(
                    padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: Colors.orange,
                                size: 18.sp), // Use ScreenUtil for icon size
                            SizedBox(width: 8.w),
                            Text(
                              'Karat: ${product.karat}',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight
                                      .w500), // Use ScreenUtil for font size
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(Icons.scale,
                                color: Colors.teal,
                                size: 18.sp), // Use ScreenUtil for icon size
                            SizedBox(width: 8.w),
                            Text(
                              'Weight: ${product.weight}gm',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight
                                      .w500), // Use ScreenUtil for font size
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Description:',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight
                                  .bold), // Use ScreenUtil for font size
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          product.description,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors
                                  .grey[700]), // Use ScreenUtil for font size
                        ),
                        SizedBox(height: 14.h),
                        Text(
                          'Verified by Bansal & Sons Jewellers',
                          style: TextStyle(
                            fontSize: 16.sp, // Use ScreenUtil for font size
                            fontWeight: FontWeight.bold,
                            color: kDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // WhatsApp and Call Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () =>
                          _launchUrl('https://wa.me/+9191982031621'),
                      icon: Image.asset(
                        'assets/icons/whatsapp.png',
                        width: 24.w, // Use ScreenUtil for width
                        height: 24.h, // Use ScreenUtil for height
                      ),
                      label: Text('WhatsApp'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12.r), // Use ScreenUtil for radius
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    ElevatedButton.icon(
                      onPressed: () => _launchUrl('tel:+9191982031621'),
                      icon: Icon(Icons.phone, color: Colors.white),
                      label: Text('Call'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12.r), // Use ScreenUtil for radius
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                CustomButton(
                  label: 'Add to Cart',
                  onPressed: () {
                    cartController.addToCart(
                        userId, product.productId.toString());
                  },
                  width: 550.w, // Use ScreenUtil for width
                  height: 50.h, // Use ScreenUtil for height
                  color: kDark,
                  fontSize: 20.sp, // Use ScreenUtil for font size
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
