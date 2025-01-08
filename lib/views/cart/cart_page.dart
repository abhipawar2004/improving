import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/views/cart/cart_detailed_file.dart';
import 'package:get/get.dart';
import 'package:gehnamall/controllers/cart_controller.dart';
import 'package:gehnamall/services/auth_service.dart';

class CartPage extends StatelessWidget {
  final cartController = Get.find<CartController>();

  Future<String> getUserId() async {
    final userId = await AuthService.getUserId();
    return userId ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil here to use it for responsive design
    ScreenUtil.init(context,
        designSize: Size(375, 825), minTextAdapt: true, splitScreenMode: true);

    return FutureBuilder<String>(
      future: getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Cart'),
              centerTitle: true,
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Cart'),
              centerTitle: true,
            ),
            body: Center(child: Text('Error retrieving user ID.')),
          );
        }

        final userId = snapshot.data ?? 'Unknown';

        cartController.fetchCartItems(userId);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: kDark,
            title: Text('My WishList'),
            centerTitle: true,
          ),
          body: Obx(() {
            if (cartController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            if (cartController.cartItems.isEmpty) {
              return Center(child: Text('No items in cart.'));
            }

            return Padding(
              padding: EdgeInsets.all(
                  10.0.w), // Using ScreenUtil for responsive padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w, // Responsive cross spacing
                        mainAxisSpacing: 10.h, // Responsive main axis spacing
                        childAspectRatio: 0.5.h,
                      ),
                      itemCount: cartController.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartController.cartItems[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to CartDetailScreen
                            Get.to(
                              CartDetailScreen(
                                item: item,
                                userId: userId,
                              ),
                            );
                          },
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15.r), // Responsive border radius
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(
                                            15.r), // Responsive border radius
                                      ),
                                      child: Image.network(
                                        item['imageUrls'][0],
                                        height: 190.h, // Responsive height
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 8.h,
                                      right: 8.w,
                                      child: GestureDetector(
                                        onTap: () {
                                          cartController.removeFromCart(
                                            userId,
                                            item['productId'].toString(),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              5.w), // Responsive padding
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 20.sp, // Responsive size
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                      10.0.w), // Responsive padding
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['productName'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              16.sp, // Responsive font size
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                          height: 5.h), // Responsive spacing
                                      Text(
                                        'Weight: ${item['weight'] + 'gm'}',
                                        style: TextStyle(
                                          fontSize:
                                              12.sp, // Responsive font size
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
