import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/custom_button.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/controllers/cart_controller.dart';
import 'package:gehnamall/controllers/product_details_controller.dart';
import 'package:gehnamall/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:gehnamall/models/product_card_models.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  final cartController = Get.put(CartController());
  final ProductDetailsController controller =
      Get.put(ProductDetailsController());

  ProductDetails({Key? key, required this.product}) : super(key: key);

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
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double screenWidth = constraints.maxWidth;
                double screenHeight = constraints.maxHeight;

                // Use percentage-based dimensions for responsive design
                double imageHeight = screenHeight * 0.4;
                double buttonWidth = screenWidth * 0.9;

                return SingleChildScrollView(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Horizontal Image Slider
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ClipRRect(
                            child: SizedBox(
                              height: imageHeight,
                              child: PageView.builder(
                                controller: controller.pageController,
                                onPageChanged: (index) =>
                                    controller.currentImageIndex.value = index,
                                itemCount: product.imageUrls.length,
                                itemBuilder: (context, index) {
                                  return CachedNetworkImage(
                                    imageUrl: product.imageUrls[index],
                                    height: 120.h,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, error, url) =>
                                        Icon(Icons.broken_image, size: 120),
                                  );
                                },
                              ),
                            ),
                          ),
                          Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(product.imageUrls.length,
                                  (index) {
                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 8),
                                  width: controller.currentImageIndex.value ==
                                          index
                                      ? 12
                                      : 8,
                                  height: controller.currentImageIndex.value ==
                                          index
                                      ? 12
                                      : 8,
                                  decoration: BoxDecoration(
                                    color: controller.currentImageIndex.value ==
                                            index
                                        ? const Color.fromARGB(
                                            255, 255, 255, 255)
                                        : Colors.grey[300],
                                    shape: BoxShape.circle,
                                  ),
                                );
                              }))),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Product Name
                      Center(
                        child: Text(
                          product.productName,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Product Details
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Karat: ${product.karat}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'Weight: ${product.weight}gm',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                             SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'MakingCharge: ${product.wastage}%',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Description: ${product.description}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 14),
                            // WhatsApp and Call Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () => _launchUrl(
                                      'https://wa.me/+9191982031621'),
                                  icon: Image.asset(
                                    'assets/icons/whatsapp.png',
                                    height: 14.h,
                                  ),
                                  label: Text('Click WhatsApp to ask!',style: TextStyle(
                                    color: Colors.green,fontSize: 8.sp,
                                  ),),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(160.w, 15.h),
                                  backgroundColor: Colors.white,
                                    side:  BorderSide(color: Colors.green, width: 2.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                ElevatedButton.icon(
                                  onPressed: () =>
                                      _launchUrl('tel:+9191982031621'),
                                  icon: Icon(Icons.phone, color: Colors.green,size:14.h,),
                                  label: Text('Click to Call!',style: TextStyle(color: Colors.green,fontSize: 8.sp),),
                                  style: ElevatedButton.styleFrom(
                                    side:  BorderSide(color: Colors.green, width: 2.w),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),

                            Row(
                              children: [
                                Icon(
                                  Icons.verified,
                                  color: kPrimary,
                                  size: 12.h,
                                ),
                                Text(
                                  ' Bansal & Sons Jewellers Pvt Ltd',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      CustomButton(
                        label: 'Add to Whishlist',
                        onPressed: () {
                          cartController.addToCart(
                              userId, product.productId.toString());
                        },
                        width: buttonWidth,
                        height: 50,
                        color: kDark,
                        fontSize: 20,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<String> getUserId() async {
    final userId = await AuthService.getUserId();
    return userId ?? 'Unknown'; // Return 'Unknown' if userId is null
  }
}
