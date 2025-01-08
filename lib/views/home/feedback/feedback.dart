import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/constants.dart';

class YourFeedback extends StatefulWidget {
  const YourFeedback({super.key});

  @override
  State<YourFeedback> createState() => _YourFeedbackState();
}

class _YourFeedbackState extends State<YourFeedback> {
  // URL for Google Review
  final String reviewUrl =
      'https://search.google.com/local/writereview?placeid=ChIJ78nbKCr9DDkRCUdu1MEiAwM&noredir=1';

  // Function to open the URL
  void _openReviewUrl() async {
    final Uri url = Uri.parse(reviewUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $reviewUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          width: 300.w,
          height: 250.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Feedback Icon/Image
              Image.asset(
                'assets/images/rate12.png',
                height: 50.h,
              ),
              // Feedback Text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  "Your feedback is a gem! Rate us to help us improve and keep dazzling you.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
              // Rate Us Button
              SizedBox(
                width: 120.w,
                height: 40.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kGray,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: _openReviewUrl,
                  child: Text(
                    'RATE US',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: kWhite,
                      fontWeight: FontWeight.bold,
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
