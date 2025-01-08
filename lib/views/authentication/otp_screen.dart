import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/views/entrypoint.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../services/auth_service.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> otpFields =
      List.generate(3, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(3, (index) => FocusNode());

  bool isLoading = false;
  bool isResendDisabled = true; // Disable resend initially
  int remainingTime = 300; // 5 minutes in seconds
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startResendTimer(); // Start the timer when the screen loads
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void startResendTimer() {
    setState(() {
      isResendDisabled = true;
      remainingTime = 300; // Reset timer to 5 minutes
    });

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          t.cancel();
          isResendDisabled = false; // Enable resend button when time is up
        }
      });
    });
  }

  Future<void> handleResendOtp() async {
    setState(() => isResendDisabled = true); // Disable button after click

    // Simulate OTP resend (call your API here if needed)
    Get.snackbar('OTP Resent', 'A new OTP has been sent to your phone.');

    // Restart the timer
    startResendTimer();
  }

  void handleOtpVerification() async {
    String otp = otpFields.map((controller) => controller.text).join();

    if (otp.length != 3) {
      Get.snackbar('Error', 'Please enter complete OTP');
      return;
    }

    setState(() => isLoading = true);

    final result = await AuthService.verifyOtp(widget.phoneNumber, otp);

    setState(() => isLoading = false);

    if (result['success']) {
      Get.offAll(() => MainScreen()); // Replace with your home screen
    } else {
      // Show error message
      String message = result['data']['message'] ?? 'Failed to verify OTP';
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),

                // Logo
                Image.asset('assets/images/applogo.png', height: 150.h),
                SizedBox(height: 5.h),

                // OTP Illustration
                Image.asset('assets/images/otpimage.png', height: 120.h),
                SizedBox(height: 20.h),

                // Title
                Text(
                  "OTP Verification",
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: kDark),
                ),
                SizedBox(height: 10.h),

                // Subtitle
                Text(
                  "Almost there! Please enter the OTP sent to\nyour device to verify your identity",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                ),
                SizedBox(height: 10.h),

                // Phone Number
                Text(
                  widget.phoneNumber,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20.h),

                // OTP Input Fields
                SizedBox(
                  width: 150.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(3, (index) {
                      return SizedBox(
                        width: 40.w,
                        height: 40.h,
                        child: TextField(
                          controller: otpFields[index],
                          focusNode: focusNodes[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: "",
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              // Move focus to the next field if value is entered
                              if (index < otpFields.length - 1) {
                                FocusScope.of(context)
                                    .requestFocus(focusNodes[index + 1]);
                              } else {
                                FocusScope.of(context).unfocus();
                              }
                            } else {
                              // Move focus to the previous field if backspace is pressed
                              if (index > 0 && otpFields[index].text.isEmpty) {
                                FocusScope.of(context)
                                    .requestFocus(focusNodes[index - 1]);
                              }
                            }
                          },
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 15.h),

                // Resend OTP Button with Timer
                InkWell(
                  onTap: isResendDisabled ? null : handleResendOtp,
                  child: Text.rich(
                    TextSpan(
                      text: "Didn't receive OTP? ",
                      style: TextStyle(fontSize: 15.sp, color: Colors.black54),
                      children: [
                        TextSpan(
                          text: isResendDisabled
                              ? "Resend OTP in ${remainingTime ~/ 60}:${(remainingTime % 60).toString().padLeft(2, '0')}"
                              : "Resend OTP",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: isResendDisabled ? Colors.grey : Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Verify Button
                InkWell(
                  onTap: isLoading ? null : handleOtpVerification,
                  child: Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: kWhite,
                      border: Border.all(color: kDark, width: 3.w),
                    ),
                    child: Center(
                      child: isLoading
                          ? CircularProgressIndicator(color: kPrimary)
                          : Text(
                              'VERIFY',
                              style:
                                  TextStyle(fontSize: 20.sp, color: kPrimary),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
