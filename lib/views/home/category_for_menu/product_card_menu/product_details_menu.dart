import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gehnamall/common/custom_button.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/controllers/cart_controller.dart';
import 'package:gehnamall/controllers/product_details_controller_menu.dart';
import 'package:gehnamall/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:gehnamall/models/product_card_models.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsMenu extends StatelessWidget {
  final Product product;
  final cartController = Get.put(CartController());
  final ProductDetailsMenuController controller =
      Get.put(ProductDetailsMenuController());

  ProductDetailsMenu({Key? key, required this.product}) : super(key: key);

  // Launch a URL or perform a specific action
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url); // Ensure the URL is parsed as Uri
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri); // Use launchUrl instead of launch
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
                fontSize: 24, // Adjust the font size
                color: Colors.white, // Set the text color
                letterSpacing: 1.2, // Add spacing between letters
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(2.0, 2.0),
                  ),
                ], // Add a subtle shadow effect to the text
              ),
            ),
            centerTitle: true,
            backgroundColor: kDark,
            automaticallyImplyLeading: false, // Hides the back arrow
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;
              double screenHeight = constraints.maxHeight;

              // Use percentage-based dimensions for responsive design
              double imageHeight = screenHeight * 0.4;
              double buttonWidth = screenWidth * 0.9;

              return SingleChildScrollView(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Horizontal Image Slider
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: imageHeight,
                            child: PageView.builder(
                              controller: controller.pageController,
                              onPageChanged: (index) =>
                                  controller.currentImageIndex.value = index,
                              itemCount: product.imageUrls.length,
                              itemBuilder: (context, index) {
                                return CachedNetworkImage(
                                  imageUrl: product.imageUrls[index],
                                  height: 220,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, error, url) =>
                                      Icon(Icons.broken_image, size: 220),
                                );
                              },
                            ),
                          ),
                        ),
                        Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(product.imageUrls.length,
                                (index) {
                              return AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 8),
                                width:
                                    controller.currentImageIndex.value == index
                                        ? 12
                                        : 8,
                                height:
                                    controller.currentImageIndex.value == index
                                        ? 12
                                        : 8,
                                decoration: BoxDecoration(
                                  color: controller.currentImageIndex.value ==
                                          index
                                      ? Colors.blue
                                      : Colors.grey[300],
                                  shape: BoxShape.circle,
                                ),
                              );
                            }))),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Product Name
                    Center(
                      child: Text(
                        product.productName,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Product Details
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: Colors.orange, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  'Karat: ${product.karat}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.scale, color: Colors.teal, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  'Weight: ${product.weight}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Description:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              product.description,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
                            ),
                            SizedBox(height: 14),
                            Text(
                              'Verified by Bansal & Sons Jewellers Pvt Ltd',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // WhatsApp and Call Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () =>
                              _launchUrl('https://wa.me/+9191982031621'),
                          icon: Image.asset(
                            'assets/icons/whatsapp.png',
                            width: 24,
                            height: 24,
                          ),
                          label: Text('WhatsApp'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
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
                      width: buttonWidth,
                      height: 50,
                      color: kDark,
                      fontSize: 20,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              );
            },
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
