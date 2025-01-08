import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gehnamall/common/custom_button.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/controllers/cart_controller.dart';
import 'package:gehnamall/controllers/product_details_controller_menu.dart';
import 'package:gehnamall/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'fetch_products_menu.dart';

class GoldBrickDetailedMenu extends StatelessWidget {
  final Product product;
  final cartController = Get.put(CartController());
  final ProductDetailsMenuController controller =
      Get.put(ProductDetailsMenuController());

  GoldBrickDetailedMenu({Key? key, required this.product}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar(
        'Error',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size using MediaQuery
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

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
              product.categoryName.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.06, // responsive font size
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
            padding: EdgeInsets.all(screenWidth * 0.04), // responsive padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: screenHeight * 0.45, // responsive height
                        child: PageView.builder(
                          controller: controller.pageController,
                          onPageChanged: (index) =>
                              controller.currentImageIndex.value = index,
                          itemCount: product.imageUrls.length,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: product.imageUrls[index],
                              height:
                                  screenHeight * 0.25, // responsive image size
                              fit: BoxFit.cover,
                              errorWidget: (context, error, url) => Icon(
                                  Icons.broken_image,
                                  size: screenHeight * 0.25),
                            );
                          },
                        ),
                      ),
                    ),
                    Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            List.generate(product.imageUrls.length, (index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            width: controller.currentImageIndex.value == index
                                ? 12
                                : 8,
                            height: controller.currentImageIndex.value == index
                                ? 12
                                : 8,
                            decoration: BoxDecoration(
                              color: controller.currentImageIndex.value == index
                                  ? Colors.blue
                                  : Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                          );
                        }))),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: Text(
                    product.productName,
                    style: TextStyle(
                      fontSize: screenWidth * 0.075, // responsive font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: Padding(
                    padding: EdgeInsets.all(
                        screenWidth * 0.04), // responsive padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Karat: ${product.karat}',
                              style: TextStyle(
                                  fontSize: screenWidth *
                                      0.04, // responsive font size
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          children: [
                            Icon(Icons.scale, color: Colors.teal, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Weight: ${product.weight}',
                              style: TextStyle(
                                  fontSize: screenWidth *
                                      0.04, // responsive font size
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          'Description:',
                          style: TextStyle(
                              fontSize:
                                  screenWidth * 0.04, // responsive font size
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          product.description,
                          style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.grey[700]),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'Verified by Bansal & Sons Jewellers Pvt Ltd',
                          style: TextStyle(
                            fontSize:
                                screenWidth * 0.04, // responsive font size
                            fontWeight: FontWeight.bold,
                            color: kDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () =>
                          _launchUrl('https://wa.me/+9191982031621'),
                      icon: Image.asset(
                        'assets/icons/whatsapp.png',
                        width: screenWidth * 0.06, // responsive icon size
                        height: screenWidth * 0.06,
                      ),
                      label: Text('WhatsApp'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03), // responsive spacing
                    ElevatedButton.icon(
                      onPressed: () => _launchUrl('tel:+9191982031621'),
                      icon: Icon(Icons.phone, color: Colors.white),
                      label: Text('Call'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomButton(
                  label: 'Add to Cart',
                  onPressed: () {
                    cartController.addToCart(
                        userId, product.productId.toString());
                  },
                  width: double.infinity,
                  height: 50,
                  color: kDark,
                  fontSize: screenWidth * 0.05, // responsive font size
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> getUserId() async {
    final userId = await AuthService.getUserId();
    return userId ?? 'Unknown'; // Return 'Unknown' if userId is null
  }
}
