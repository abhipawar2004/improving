// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/models/light_category_models.dart';
import 'package:gehnamall/views/home/lightCategories/light_product_screen.dart';
import 'package:get/get.dart';

class LightCategoryWidget extends StatelessWidget {
  LightCategoryWidget({
    super.key,
    required this.lightCategories,
  });

  final LightCategoryModels lightCategories;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the product screen on tap
        Get.to(() => LightProductScreen(
              categoryCode: lightCategories.categoryCode.toString(),
              wholeseller: 'BANSAL',
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: EdgeInsets.symmetric(vertical: 4.h),
        width: 50.w, // Adjusted for better responsiveness
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: kWhite,
            width: 0.5.w,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40.h, // Ensure consistent image sizing
              width: 40.h,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: lightCategories.exfield1,
                  fit: BoxFit.cover, // Ensure the image covers without overflow
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                  ),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, size: 20.r),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Flexible(
              child: Text(
                lightCategories.categoryName,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: kDark,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
