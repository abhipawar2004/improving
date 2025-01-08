import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/app_style.dart';

class GiftingWidgets extends StatelessWidget {
  const GiftingWidgets({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });

  final String image;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 8.w, vertical: 6.h), // Adjust padding for scaling
        child: Container(
          width: 150.w, // Adjusts based on screen width
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.w), // Padding for spacing
                child: Container(
                  height: 100.h, // Scaled height
                  width:
                      double.infinity, // Makes the image container fill width
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.grey.shade200, // Placeholder background
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit
                          .cover, // Ensures the image covers the container
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: appStyle(
                        12, // Adjust font size based on screen size
                        Colors.black,
                        FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis, // Prevents overflow
                      maxLines: 1, // Limits to one line
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
