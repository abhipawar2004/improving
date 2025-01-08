import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/hooks/fetch_soulmate_list.dart';
import 'package:gehnamall/views/home/occasion/Occasion_Product_Detailed_Screen.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SoulmateProductScreen extends StatelessWidget {
  final String soulmateName;
  final String wholeseller;

  const SoulmateProductScreen({
    required this.soulmateName,
    required this.wholeseller,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OccasionSoulmateController());
    controller.fetchSoulmateProducts(soulmateName, wholeseller);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 45.h), // Scalable top padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Heading
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w, // Scalable horizontal padding
                vertical: 30.h, // Scalable vertical padding
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.h, // Scalable thickness
                      endIndent: 10.w, // Scalable endIndent
                    ),
                  ),
                  Text(
                    soulmateName,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20.sp, // Scalable font size
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.h, // Scalable thickness
                      indent: 10.w, // Scalable indent
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
                return const SizedBox(); // Return an empty widget if error occurs
              }
              final products =
                  controller.soulmateCardModels.value?.products ?? [];
              if (products.isEmpty) {
                return const Center(child: Text('No products available.'));
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(10.w), // Scalable padding
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w, // Scalable cross axis spacing
                  mainAxisSpacing: 10.h, // Scalable main axis spacing
                  childAspectRatio: 0.5.h, // Adjusted aspect ratio
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final soulmate = products[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to ProductDetailScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            product: soulmate,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.r), // Scalable border radius
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
                                  top: Radius.circular(
                                      20.r), // Scalable border radius
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: soulmate.imageUrls.first,
                                  height: 180.h, // Scalable height
                                  width: double.infinity,
                                  fit: BoxFit
                                      .cover, // Ensure the image fits correctly
                                ),
                              ),
                              Positioned(
                                top: 8.h,
                                right: 8.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: golden,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    soulmate.karat.toString(),
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
                                    color: lightgrey,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    soulmate.weight.toString(),
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
                            padding: EdgeInsets.all(10.w), // Scalable padding
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    soulmate.categoryName.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp, // Scalable font size
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 6.h), // Scalable spacing
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: kDark,
                                      size: 15.sp, // Scalable icon size
                                    ),
                                    Expanded(
                                      child: Text(
                                        ' By Bansal & Sons',
                                        style: TextStyle(
                                          fontSize: 12.sp, // Scalable font size
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
