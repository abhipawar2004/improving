import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/app_style.dart';

class CategoriesWidgetsForAppBar extends StatelessWidget {
  CategoriesWidgetsForAppBar({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100
                .w, // Define a width for the container relative to the screen size
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: appStyle(15, Colors.black, FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
