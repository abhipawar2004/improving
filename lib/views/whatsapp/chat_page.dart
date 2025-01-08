import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/custom_container.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  // Function to launch the WhatsApp URL
  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomContainer(
          containerContent: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App Logo
                  Image.asset(
                    'assets/images/applogo.png',
                    width: 450.w,
                    height: 300.h,
                  ),

                  SizedBox(height: 20.h), // Space between the logo and text

                  // Text
                  Text(
                    'If you have any question, click the button below to chat with us on WhatsApp',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20.h), // Space between the text and button

                  // WhatsApp Button
                  ElevatedButton(
                    onPressed: () => _launchUrl('https://wa.me/+9191982031621'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // WhatsApp color
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 40.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icons/whatsapp.png',
                          height: 25.h,
                          width: 25.w,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Chat on WhatsApp',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
