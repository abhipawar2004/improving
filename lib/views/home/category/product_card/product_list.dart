import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/hooks/fetch_product_list.dart';
import 'package:gehnamall/views/home/category/product_card/product_widgets.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  var selectedGenderCode = Rx<int?>(null);

  void setGender(int? genderCode) {
    selectedGenderCode.value = genderCode;
  }
}

class ProductList extends StatelessWidget {
  final int categoryCode;
  final int subCategoryCode;
  final String subCategoryName;
  final ProductListController controller = Get.put(ProductListController());

  ProductList({
    Key? key,
    required this.categoryCode,
    required this.subCategoryCode,
    required this.subCategoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 45.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Heading
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
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
                    subCategoryName.toUpperCase(),
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
              final genderCode = controller.selectedGenderCode.value;
              return ProductListView(
                categoryCode: categoryCode,
                subCategoryCode: subCategoryCode,
                genderCode: genderCode,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ProductListView extends HookWidget {
  final int categoryCode;
  final int subCategoryCode;
  final int? genderCode;

  const ProductListView({
    Key? key,
    required this.categoryCode,
    required this.subCategoryCode,
    required this.genderCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fetchHook =
        useFetchProductList('BANSAL', categoryCode, subCategoryCode);

    return fetchHook.isloading
        ? Center(child: CircularProgressIndicator())
        : fetchHook.data == null || fetchHook.data!.isEmpty
            ? Center(
                child: Text(
                  'No Products Available',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black54,
                  ),
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(10.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 0.5.h,
                ),
                itemCount: fetchHook.data!.length,
                itemBuilder: (context, index) {
                  final product = fetchHook.data![index];
                  if (genderCode != null && product.genderCode != genderCode) {
                    return Container();
                  }
                  return ProductCard(product: product);
                },
              );
  }
}
