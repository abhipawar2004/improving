import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/hooks/fetch_lightcategory_list.dart';
import 'package:gehnamall/views/home/lightCategories/light_Product_Detailed_Screen.dart';
import 'package:get/get.dart';

class LightProductScreen extends StatelessWidget {
  final String categoryCode;
  final String wholeseller;

  const LightProductScreen({
    Key? key,
    required this.categoryCode,
    required this.wholeseller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive design
    ScreenUtil.init(context,
        designSize: const Size(375, 825),
        minTextAdapt: true,
        splitScreenMode: true);

    final controller = Get.put(lightController());
    controller.fetchLightProducts(categoryCode, wholeseller);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: kDark,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.error.isNotEmpty) {
                return Center(child: Text(controller.error.value));
              }
              final products = controller.lightCardModels.value?.products ?? [];
              if (products.isEmpty) {
                return const Center(child: Text('No products available.'));
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio:
                      0.6, // Adjusted for better scaling on devices
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final light = products[index];
                  final karat = light.karat ?? 0;
                  final weight = light.weight ?? 0;
                  final price = light.price ?? 0;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LightDetailScreen(
                            product: light,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15.r),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: light.imageUrls.first,
                                  height: 160.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 10.h,
                                right: 10.w,
                                child: Badge(
                                  value: karat.toString(),
                                  color: Colors.red,
                                ),
                              ),
                              Positioned(
                                top: 10.h,
                                left: 10.w,
                                child: Badge(
                                  value: weight.toString() + 'gm',
                                  color: Colors.blue.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  light.categoryName ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.store,
                                      color: kDark,
                                      size: 15.sp,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      'Bansal & Sons',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: kDark,
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

class Badge extends StatelessWidget {
  final String value;
  final Color color;

  const Badge({required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
