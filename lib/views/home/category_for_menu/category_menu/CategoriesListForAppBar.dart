import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/hooks/fetchCategory.dart';
import 'package:gehnamall/models/category_models.dart';
import 'package:gehnamall/views/home/category_for_menu/4007/gold_brick_menu.dart';
import 'package:gehnamall/views/home/category_for_menu/category_menu/CategoriesWidgetsForAppBar.dart';
import 'package:gehnamall/views/home/category_for_menu/gender_selction_menu/Gender_selection_menu.dart';
import 'package:gehnamall/views/home/category_for_menu/subCategory_menu/subcategory_list_menu.dart';
import 'package:get/get.dart';

class CategoriesListForAppBar extends HookWidget {
  const CategoriesListForAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = UseFetchCategories();
    List<CategoryModels>? categoriesList = hookResult.data;
    final isLoading = hookResult.isloading;
    final error = hookResult.error;

    // Ensure proper initialization of ScreenUtil
    ScreenUtil.init(context);

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    if (error != null) {
      return Center(
        child: Text(
          'Error: Sorry, please try with good internet',
          style: TextStyle(fontSize: 16.sp, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (categoriesList == null || categoriesList.isEmpty) {
      return Center(
        child: Text(
          'No categories available.',
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: categoriesList.length,
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
        itemBuilder: (context, i) {
          CategoryModels category = categoriesList[i];
          return CategoriesWidgetsForAppBar(
            title: category.categoryName,
            onTap: () {
              if ([4007, 4008, 4009].contains(category.categoryCode)) {
                Get.to(
                  () => ProductsListMenu(categoryCode: category.categoryCode),
                  transition: Transition.cupertino,
                  duration: const Duration(milliseconds: 900),
                );
              } else if (category.categoryCode == 4001 ||
                  category.categoryCode == 4002) {
                Get.to(
                  () => GenderSelectionMenu(
                    onGenderSelected: (int selectedGenderCode) {
                      Get.to(
                        () => SubcategoryListMenu(
                          categoryCode: category.categoryCode,
                          selectedGenderCode: selectedGenderCode,
                        ),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 900),
                      );
                    },
                  ),
                  transition: Transition.cupertino,
                  duration: const Duration(milliseconds: 900),
                );
              } else {
                Get.to(
                  () =>
                      SubcategoryListMenu(categoryCode: category.categoryCode),
                  transition: Transition.cupertino,
                  duration: const Duration(milliseconds: 900),
                );
              }
            },
          );
        },
      ),
    );
  }
}
