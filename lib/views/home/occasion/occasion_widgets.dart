import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OccasionWidgets extends StatelessWidget {
  const OccasionWidgets({
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
        padding: EdgeInsets.all(8.w), // Responsive padding
        child: Container(
          width: 0.4.sw, // 40% of screen width
          height: 0.3.sh, // 30% of screen height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 0.2.sh, // 20% of screen height for the image
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.yellow,
                    width: 3.w, // Responsive border width
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
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
              ),
              Padding(
                padding: EdgeInsets.all(3),
                child: Text(
                  title,
                  maxLines: 1, // Limit to one line
                  overflow:
                      TextOverflow.ellipsis, // Avoid overflow with ellipsis
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp, // Adjusted font size for clarity
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
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
