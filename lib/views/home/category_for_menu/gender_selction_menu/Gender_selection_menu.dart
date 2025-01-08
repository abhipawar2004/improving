import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderSelectionMenu extends StatefulWidget {
  final Function(int) onGenderSelected;

  const GenderSelectionMenu({Key? key, required this.onGenderSelected})
      : super(key: key);

  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelectionMenu> {
  int? _selectedGenderCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGenderCode = 1; // Male
                    });
                    widget.onGenderSelected(1); // Male
                  },
                  child: _buildGenderCard(
                    'assets/images/mens.jpg',
                    'Men',
                  ),
                ),
                SizedBox(width: 20.w), // Responsive spacing
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGenderCode = 2; // Female
                    });
                    widget.onGenderSelected(2); // Female
                  },
                  child: _buildGenderCard(
                    'assets/images/womens.jpg',
                    'Women',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderCard(String imagePath, String genderLabel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              imagePath,
              width: 150.w,
              height: 150.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 12.h), // Responsive spacing
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Text(
            genderLabel,
            style: TextStyle(
              fontSize: 18.sp, // Scaled font size
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
