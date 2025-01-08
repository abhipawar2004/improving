import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/app_style.dart';

class SoulmateWidgets extends StatelessWidget {
  const SoulmateWidgets({
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
        padding: EdgeInsets.all(8.w), // Use screen width scaling for padding
        child: Container(
          width: 150.w, // Scaled width
          height: 250.h, // Scaled height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200.h, // Scaled height for the image container
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.yellow,
                      width: 3.w,
                    ),
                    bottom: BorderSide(
                      color: Colors.yellow,
                      width: 3.w,
                    ),
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w, // Scales horizontal padding
                  vertical: 3.h, // Scales vertical padding
                ),
                child: Container(
                  child: FittedBox(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: appStyle(15, Colors.black,
                          FontWeight.normal), // Scales text size
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
