import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectWithUs extends StatefulWidget {
  const ConnectWithUs({super.key});

  @override
  State<ConnectWithUs> createState() => _ConnectWithUsState();
}

class _ConnectWithUsState extends State<ConnectWithUs> {
  // Function to open WhatsApp with a pre-filled message
  void _openWhatsApp() async {
    String phoneNumber = "+91982031621"; // Indian phone number
    String message =
        "Hello, I have a question regarding the product from your app.";
    String url =
        "https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("WhatsApp is not installed or cannot be launched."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w), // Responsive padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCard(
            onTap: _openWhatsApp,
            imagePath: 'assets/icons/whatsapp.png',
            label: 'Connect on\nWhatsApp',
          ),
          _buildCard(
            onTap: _openWhatsApp,
            imagePath: 'assets/images/videocall.png',
            label: 'Schedule\nVideo Call',
          ),
          _buildCard(
            onTap: _openWhatsApp,
            icon: FontAwesomeIcons.clockRotateLeft,
            label: 'Latest\nUpdate',
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required VoidCallback onTap,
    String? imagePath,
    IconData? icon,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: kWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 4,
        margin: EdgeInsets.all(8.r),
        child: Container(
          width: 90.w,
          height: 120.h,
          padding: EdgeInsets.all(12.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imagePath != null)
                Image.asset(
                  imagePath,
                  height: 40.h,
                  fit: BoxFit.contain,
                )
              else if (icon != null)
                Icon(
                  icon,
                  size: 35,
                ),
              SizedBox(height: 5.h),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
