import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/app_style.dart';

class CategoriesWidgets extends StatelessWidget {
  const CategoriesWidgets({
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
        padding: EdgeInsets.all(8.w), // Adjust padding using ScreenUtil
        child: Container(
          width: 150.w, // Dynamic width using ScreenUtil
          constraints: BoxConstraints(
            maxHeight: 180.h, // Ensure container doesn't overflow
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 120.h, // Dynamic height using ScreenUtil
                width: 150.w, // Match width of parent container
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.yellow,
                      width: 3.w, // Adjust width using ScreenUtil
                    ),
                    top: BorderSide(
                      color: Colors.yellow,
                      width: 3.w, // Adjust width using ScreenUtil
                    ),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover, // Prevent overflow
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h), // Add spacing
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: appStyle(
                    12, // Adjust text size dynamically using ScreenUtil
                    Colors.black,
                    FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2, // Limit lines to prevent overflow
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
