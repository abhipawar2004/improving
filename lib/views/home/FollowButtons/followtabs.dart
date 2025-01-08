import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowTabs extends StatelessWidget {
  const FollowTabs({Key? key}) : super(key: key);

  // Launch a URL or perform a specific action
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url); // Ensure the URL is parsed as Uri
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri); // Use launchUrl instead of launch
    } else {
      Get.snackbar(
        'Error',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFollowButton(
              assetPath: 'assets/icons/instagram.png',
              label: 'Instagram',
              onTap: () => _launchUrl(
                'https://www.instagram.com/bansal_and_sons_jewellers?igsh=MWQ5MWJ3dXNmZWlyeA==',
              ),
            ),
            _buildFollowButton(
              assetPath: 'assets/icons/whatsapp.png',
              label: 'WhatsApp',
              onTap: () => _launchUrl('https://wa.me/+9191982031621'),
            ),
            _buildFollowButton(
              assetPath: 'assets/icons/facebook.png',
              label: 'Facebook',
              onTap: () => _launchUrl(
                'https://www.facebook.com/bansalandsonsjewellerspvtltd?mibextid=ZbWKwL',
              ),
            ),
            _buildFollowButton(
              assetPath: 'assets/icons/youtube.png',
              label: 'YouTube',
              onTap: () => _launchUrl(
                'https://www.youtube.com/@bansalsonsjewellers6387',
              ),
            ),
            _buildFollowButton(
              assetPath: 'assets/icons/social.png',
              label: 'Pinterest',
              onTap: () => _launchUrl('https://pin.it/2ACtK6wmi'),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build individual follow buttons
  Widget _buildFollowButton({
    required String assetPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            assetPath,
            width: 60.w,
            height: 40.h,
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
