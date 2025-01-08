import 'package:flutter/material.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/controllers/cart_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;
  final String userId;
  final cartController = Get.find<CartController>();

  CartDetailScreen({Key? key, required this.item, required this.userId})
      : super(key: key);

  Future<String> getUserId() async {
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context,
        designSize: const Size(375, 825), minTextAdapt: true);

    return FutureBuilder<String>(
      future: getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error retrieving user ID.'));
        }

        final userId = snapshot.data ?? 'Unknown';

        return Scaffold(
          appBar: AppBar(
            title: Text(
              item['productName'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.sp, // Use ScreenUtil for text size
                color: Colors.white,
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            backgroundColor: kDark,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(12.r), // Use ScreenUtil for radius
                  child: Image.network(
                    item['imageUrls'][0],
                    height: 420.h, // Use ScreenUtil for height
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20.h), // Use ScreenUtil for spacing

                // Product Name
                Center(
                  child: Text(
                    item['productName'],
                    style: TextStyle(
                      fontSize: 28.sp, // Use ScreenUtil for text size
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Product Details
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.r), // Use ScreenUtil for radius
                  ),
                  elevation: 4,
                  margin: EdgeInsets.symmetric(
                      vertical: 8.h), // Use ScreenUtil for margin
                  child: Padding(
                    padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: Colors.orange,
                                size: 18.sp), // Use ScreenUtil for icon size
                            SizedBox(width: 8.w), // Use ScreenUtil for spacing
                            Text(
                              'Karat: ${item['karat']}',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(Icons.scale, color: Colors.teal, size: 18.sp),
                            SizedBox(width: 8.w),
                            Text(
                              'Weight: ${item['weight']}',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: Colors.green,
                              size: 18.sp, // Use ScreenUtil for icon size
                            ),
                            SizedBox(width: 8.w), // Use ScreenUtil for spacing
                            Text(
                              'Price: ₹${item['price']}',
                              style: TextStyle(
                                fontSize: 16.sp, // Use ScreenUtil for text size
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Description: ${item['description']}',
                          style: TextStyle(
                              fontSize: 14.sp, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 14.h),
                        Text(
                          'Verified by Bansal & Sons',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: kDark,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: SizedBox(
                    width: 350.w, // Use ScreenUtil for width
                    height: 50.h, // Use ScreenUtil for height
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Remove from Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        cartController.removeFromCart(
                            userId, item['productId'].toString());
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              18.r), // Use ScreenUtil for radius
                        ),
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 20.w), // Use ScreenUtil for padding
                        elevation: 6,
                        shadowColor: Colors.black.withOpacity(0.2),
                        textStyle: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
