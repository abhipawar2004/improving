import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/custom_button.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/controllers/cart_controller.dart';
import 'package:gehnamall/controllers/product_details_controller.dart';
import 'package:gehnamall/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/lightcategorycardModels.dart';

class LightDetailScreen extends StatelessWidget {
  final Product product;
  final cartController = Get.put(CartController());
  final ProductDetailsController controller =
      Get.put(ProductDetailsController());

  LightDetailScreen({Key? key, required this.product}) : super(key: key);

  Future<String> getUserId() async {
    final userId = await AuthService.getUserId();
    return userId ?? 'Unknown';
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
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
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Standard design size (iPhone X)
      builder: (context, child) => FutureBuilder<String>(
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
                  fontSize: 20.sp, // Use ScreenUtil for font size
                  color: Colors.white,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(2.w, 2.h),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              backgroundColor: kDark,
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Horizontal Image Slider
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: SizedBox(
                          height: 240.h,
                          child: PageView.builder(
                            controller: controller.pageController,
                            onPageChanged: (index) =>
                                controller.currentImageIndex.value = index,
                            itemCount: product.imageUrls.length,
                            itemBuilder: (context, index) {
                              return CachedNetworkImage(
                                imageUrl: product.imageUrls[index],
                                height: 220.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorWidget: (context, error, url) =>
                                    Icon(Icons.broken_image, size: 220.h),
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
                                  horizontal: 4.w, vertical: 8.h),
                              width: controller.currentImageIndex.value == index
                                  ? 12.w
                                  : 8.w,
                              height:
                                  controller.currentImageIndex.value == index
                                      ? 12.h
                                      : 8.h,
                              decoration: BoxDecoration(
                                color:
                                    controller.currentImageIndex.value == index
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
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Product Details
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star,
                                  color: Colors.orange, size: 18.sp),
                              SizedBox(width: 8.w),
                              Text(
                                'Karat: ${product.karat}',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(Icons.scale,
                                  color: Colors.teal, size: 18.sp),
                              SizedBox(width: 8.w),
                              Text(
                                'Weight: ${product.weight}gm',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Description:',
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            product.description,
                            style: TextStyle(
                                fontSize: 12.sp, color: Colors.grey[700]),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            'Verified by Bansal & Sons Jewellers Pvt Ltd',
                            style: TextStyle(
                              fontSize: 14.sp,
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
                    children: [
                      ElevatedButton.icon(
                        onPressed: () =>
                            _launchUrl('https://wa.me/+9191982031621'),
                        icon: Image.asset(
                          'assets/icons/whatsapp.png',
                          width: 20.w,
                          height: 20.h,
                        ),
                        label: Text('WhatsApp'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
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
                            borderRadius: BorderRadius.circular(12.r),
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
                    width: 1.sw, // Use full screen width
                    height: 50.h,
                    color: kDark,
                    fontSize: 18.sp,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
