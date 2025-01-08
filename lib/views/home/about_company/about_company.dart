import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/constants.dart';

class AboutCompany extends StatefulWidget {
  const AboutCompany({super.key});

  @override
  State<AboutCompany> createState() => _AboutCompanyState();
}

class _AboutCompanyState extends State<AboutCompany> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Welcome to Bansal and Sons Jewellers\n\nA legacy of trust, quality, and excellence\n\n Bansal and Sons Jewellers has been a trustworthy name in the world of jewellery since many years. Our family-owned business was founded by Mr. Rakesh Bansal.\n\nOur mission at Bansal and Sons Jewellers, we are committed to:\n\n1. Creating trending jewellery designs that exceed our customers' expectations.\n2. Providing exceptional customer service that builds trust and loyalty.\n3. Our aim is to make Bansal and Sons Jewellers a nationwide and then a worldwide jewellery store.\n\nAwards by Celebrity:\n\n We are proud to receive national and international awards, a testament to our commitment to excellence.",
              maxLines: isExpanded ? null : 5,
              overflow:
                  isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kGray,
                  fixedSize: Size(150.w, 40.h), // Adjusted for better scaling
                ),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? "Read Less" : "Read More",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 14.sp, // Scaling the text size
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
