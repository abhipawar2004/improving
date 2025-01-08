import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controllers/banner_controller.dart';
import 'package:gehnamall/models/testimonial_models.dart';

class TestimonialWidget extends StatelessWidget {
  final TestimonialModels testimonial;

  TestimonialWidget({required this.testimonial});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(
      () => GestureDetector(
        onTap: () =>
            controller.banner.value = testimonial.testimonialId.toString(),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 8.w, // Responsive horizontal margin
            vertical: 4.h, // Responsive vertical margin
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(15.r), // Responsive rounded corners
                child: CachedNetworkImage(
                  imageUrl: testimonial.imageUrl,
                  height: 300.h, // Responsive height
                  width: double.infinity,
                  fit: BoxFit.contain, // Ensures the image scales properly
                ),
              ),
              if (controller.banner.value == testimonial.testimonialId)
                Positioned(
                  bottom: 20.h, // Responsive bottom padding
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w, // Responsive horizontal padding
                      vertical: 8.h, // Responsive vertical padding
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'Selected',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp, // Responsive font size
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
