import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/constants/constants.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive design
    ScreenUtil.init(
      context,
      designSize: Size(360, 690), // Design size should match the mockup size
      minTextAdapt: true,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        title: null, // No title in the app bar
        centerTitle: true,
        backgroundColor: kDark,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading outside of the app bar with red color
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: kDark, // Red color for the heading
                  ),
                ),
              ),
              // Terms and conditions content
              Text(
                'Please read these terms of use carefully before using this website. If you do not agree to these terms, you may not use this website. By using this website, you signify your explicit agreement to these Terms of Use and the Privacy Policy (which is incorporated by reference herein).\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              Text(
                'General Terms\n',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '1. Applicability:\nThese Terms of Use set forth the legally binding terms for services available on the website. They apply to both:\n- Users/Guests: Visitors who do not transact business on the website.\n- Members: Registered users who transact business on the website.\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              Text(
                '2. Modifications and Termination:\nThe Company reserves the right to modify or terminate any portion of the website or its services without prior notice or liability.\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              Text(
                '3. Review Responsibility:\nUsers are responsible for regularly reviewing these Terms of Use to stay updated with any changes.\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              Text(
                '4. Compliance:\nAs per government regulations, all designs above 2 grams are BIS hallmarked.\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Our Promise\n',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'This website offers access to trading, pricing, news, and information services related to diamonds, gems, and jewelry. Certain services are restricted to Members, and terms differ for:\n- Personal consumption purchases\n- Investment purposes\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              Text(
                '1. Personal Consumption:\nMembers can purchase customized and ready-made jewelry.\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              Text(
                '2. Investment Services:\nThe website recommends diamonds and gemstones for investment.\nRecommendations by consultants are provided but are not guaranteed. The Company will not be liable for losses incurred based on such recommendations.\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              Text(
                '3. Disclaimer on Display:\nItems may appear larger or smaller than their actual size due to screen defaults or photography techniques.\nThe Company will not be held liable for discrepancies in appearance.\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Retail Purchases\n',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Members can place orders in the following ways:\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              Text(
                '1. Online Orders:\n- Add selected diamonds directly to the shopping cart.\n- Customize jewelry (rings, pendants, earrings, etc.) and then add to the cart.\n- Select from the available ready-made jewelry and add to the cart.\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              Text(
                '2. Phone Orders:\nCall our trained consultants at +(91) 8585995522.\nThe order form will be provided via email, fax, or courier based on convenience.\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Order Process\n',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '1. Registration:\nUsers may need to register on the website to complete their purchase.\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              Text(
                '2. PAN/GST Requirements:\nFor products over ₹50,000, Members must provide:\n- Permanent Account Number (PAN)\n- GST details (if applicable)\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              Text(
                '3. Payment and Completion:\nOrders are complete only after payment is received.\n\n',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
