import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/hooks/fetch_occasion_list.dart';
import 'package:gehnamall/views/home/occasion/Occasion_Product_Detailed_Screen.dart';
import 'package:get/get.dart';

class OccasionProductScreen extends StatelessWidget {
  final String occasion;
  final String wholeseller;

  const OccasionProductScreen({
    required this.occasion,
    required this.wholeseller,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OccasionController());
    controller.fetchProducts(occasion, wholeseller);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 45.h), // Adjust top padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Heading
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 30.h,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.h,
                      endIndent: 10.w,
                    ),
                  ),
                  Text(
                    occasion,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20.sp, // Responsive font size
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.h,
                      indent: 10.w,
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.error.isNotEmpty) {
                print('Error: ${controller.error.value}');
                return const SizedBox();
              }
              final products =
                  controller.occasionCardModels.value?.products ?? [];
              if (products.isEmpty) {
                return const Center(child: Text('No products available.'));
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(10.w), // Responsive padding
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w, // Responsive spacing
                  mainAxisSpacing: 10.h, // Responsive spacing
                  childAspectRatio: 0.5.h, // Responsive aspect ratio
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            product: product,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      color: Colors.black.withOpacity(0.2),
                      shadowColor: Colors.black.withOpacity(0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.r),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: product.imageUrls.first,
                                  height: 180.h, // Responsive height
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8.h,
                                right: 8.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5E380),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    product.karat.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8.h,
                                left: 8.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 223, 214, 214),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    product.weight.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.w), // Responsive padding
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.categoryName.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp, // Responsive font size
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow
                                      .ellipsis, // Show ellipsis for overflow
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: kDark,
                                      size: 15.sp, // Responsive icon size
                                    ),
                                    Expanded(
                                      child: Text(
                                        ' By Bansal & Sons',
                                        style: TextStyle(
                                          fontSize:
                                              12.sp, // Responsive font size
                                          color: kDark,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
