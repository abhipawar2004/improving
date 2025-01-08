import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/hooks/fetch_gifting_list.dart';
import 'package:gehnamall/views/home/occasion/Occasion_Product_Detailed_Screen.dart';

class GiftingProductScreen extends StatelessWidget {
  final String giftingName;
  final String wholeseller;

  const GiftingProductScreen({
    required this.giftingName,
    required this.wholeseller,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OccasionGiftingController());
    controller.fetchGiftingProducts(giftingName, wholeseller);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Heading
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
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
                      giftingName,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20.sp,
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
                  return Center(
                    child: Text(
                      'Error: ${controller.error.value}',
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  );
                }
                final products =
                    controller.giftingCardModels.value?.products ?? [];
                if (products.isEmpty) {
                  return Center(
                    child: Text(
                      'No products available.',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  );
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 0.5.h, // Adjusted for better scaling
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final gifting = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              product: gifting,
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
                            // Product Image
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.r),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: gifting.imageUrls.isNotEmpty
                                        ? gifting.imageUrls.first
                                        : 'https://via.placeholder.com/150',
                                    height: 180.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      color: Colors.grey[300],
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 40.sp,
                                        color: Colors.grey,
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
                                      '${gifting.weight}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 10.sp,
                                      ),
                                    ),
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
                                      '${gifting.karat}',
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
                            // Product Details
                            Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    gifting.categoryName.toString(),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.store,
                                        color: kDark,
                                        size: 10.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Expanded(
                                        child: Text(
                                          'By Bansal & Sons',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: kDark,
                                          ),
                                          overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
