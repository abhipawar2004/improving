import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/models/product_card_models.dart';
import 'package:gehnamall/views/home/category/product_card/product_details.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(product: product),
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
                    imageUrl: product.imageUrls.isNotEmpty
                        ? product.imageUrls[0]
                        : 'https://via.placeholder.com/150',
                    height: 140.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.w,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: lightgrey,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '${product.weight}',
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: golden,
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
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.store,
                        color: kDark,
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          'By Bansal & Sons',
                          style: TextStyle(
                            fontSize: 12.sp,
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
  }
}
