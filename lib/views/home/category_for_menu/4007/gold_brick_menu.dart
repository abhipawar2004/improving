import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Ensure this import is added
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/views/home/category_for_menu/4007/goldbrickdetailed_menu.dart';
import 'fetch_products_menu.dart';

class ProductsListMenu extends StatelessWidget {
  final int categoryCode;

  const ProductsListMenu({super.key, required this.categoryCode});

  @override
  Widget build(BuildContext context) {
    final double itemSpacing = 10.w;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDark,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 45.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: fetchProductsMenu(categoryCode),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final products = snapshot.data as List<Product>;
                if (products.isEmpty) {
                  return const Center(child: Text('No products available.'));
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(itemSpacing),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: itemSpacing,
                    mainAxisSpacing: itemSpacing,
                    childAspectRatio: 0.5
                        .h, // Adapt this to maintain correct aspect ratio on all devices
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GoldBrickDetailedMenu(product: product),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
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
                                    imageUrl: product.imageUrls.isNotEmpty
                                        ? product.imageUrls[0]
                                        : 'https://via.placeholder.com/150',
                                    height:
                                        140.h, // Adjusted for responsiveness
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8.h,
                                  left: 8.w,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 6.h),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Text(
                                      '${product.weight}g',
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
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Text(
                                      '${product.karat}',
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
                              padding:
                                  EdgeInsets.all(10.w), // Apply scaling here
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.productName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          16.sp, // Adjusted for responsiveness
                                      color: Colors.black87,
                                    ),
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    product.description,
                                    style: TextStyle(
                                      fontSize:
                                          12.sp, // Adjusted for responsiveness
                                      color: Colors.black54,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.store,
                                        color: Colors.grey[700],
                                        size: 15.sp,
                                      ),
                                      Expanded(
                                        child: Text(
                                          ' By Bansal & Sons',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
