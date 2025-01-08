import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  // Function to open email
  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      // If it doesn't open the email client, fallback to opening the Gmail URL in the browser
      final Uri fallbackUri =
          Uri.parse('https://mail.google.com/mail/?view=cm&fs=1&to=$email');
      if (await canLaunchUrl(fallbackUri)) {
        await launchUrl(fallbackUri);
      } else {
        throw 'Could not open email client or Gmail in the browser';
      }
    }
  }

  // Function to dial a phone number
  void _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w), // Responsive padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Section (Address, Email, Contact)
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.h),
                Text(
                  "1167/1094, lift wali\nbuilding, Ground floor,\n3rd floor, 4th floor,\nKucha Mahajani,\nChandni Chowk,\nDelhi-110006",
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Email",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () => _launchEmail("info@bansalandsonsjewellers.com"),
                  child: Text(
                    "info@bansalandsonsjewellers.com",
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                    softWrap:
                        false, // Prevent text from wrapping into multiple lines
                    overflow: TextOverflow
                        .ellipsis, // Optionally, you can add this to truncate if the text is too long
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Contact",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => _launchPhone("+919810080068"),
                      child: Text(
                        "+91-9810080068",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    InkWell(
                      onTap: () => _launchPhone("+919818386380"),
                      child: Text(
                        "+91-9818386380",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    InkWell(
                      onTap: () => _launchPhone("+918802878783"),
                      child: Text(
                        "+91-8802878783",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    InkWell(
                      onTap: () => _launchPhone("+917982031621"),
                      child: Text(
                        "+91-7982031621",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Right Section (Careers)
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Careers",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Blog",
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Offer and Contact Details",
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Help and FAQ",
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Bansal & Sons Jewellers Pvt. Ltd",
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
