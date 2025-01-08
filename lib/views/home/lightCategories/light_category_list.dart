import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/shimmers/Light_categories_shimmer.dart';
import 'package:gehnamall/hooks/fetchLightCategory.dart';
import 'package:gehnamall/models/light_category_models.dart';
import 'package:gehnamall/views/home/lightCategories/light_category_widgets.dart';

class LightCategoryList extends HookWidget {
  const LightCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = UseFetchLightCategories();
    List<LightCategoryModels>? lightCategoriesList = hookResult.data;
    final isLoading = hookResult.isloading;
    final error = hookResult.error;

    if (isLoading) {
      return const LightCatergoriesShimmer();
    }

    if (error != null) {
      return Center(
        child: Text(
          'Error: Please try again with a stable internet connection.',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (lightCategoriesList == null || lightCategoriesList.isEmpty) {
      return Center(
        child: Text(
          'No categories available.',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      height: 100.h, // Adjusted for better responsiveness
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: lightCategoriesList.length,
        itemBuilder: (context, i) {
          LightCategoryModels lightCategory = lightCategoriesList[i];
          return Padding(
            padding: EdgeInsets.only(right: 8.w), // Space between categories
            child: LightCategoryWidget(lightCategories: lightCategory),
          );
        },
      ),
    );
  }
}
