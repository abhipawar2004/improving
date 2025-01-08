import 'package:flutter/material.dart';
import 'package:gehnamall/services/auth_service.dart';
import 'package:gehnamall/views/authentication/login_screen.dart'; // Update with your login screen path
import 'package:gehnamall/views/entrypoint.dart'; // Update with your main screen path
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/bansal.mp4')
      ..initialize().then((_) {
        setState(() {}); // Rebuild the widget when the video is loaded
        _controller.play();
        _controller.setLooping(true); // Loop the video
      });

    // Delay to navigate after the video finishes
    Future.delayed(const Duration(seconds: 4), () {
      _navigateToNextScreen();
    });
  }

  // Navigate to the next screen (Home or Login based on the auth state)
  _navigateToNextScreen() async {
    bool isLoggedIn = await AuthService.isUserLoggedIn();
    if (isLoggedIn) {
      Get.offAll(MainScreen()); // Navigate to home screen if logged in
    } else {
      Get.offAll(LoginScreen()); // Navigate to login screen if not logged in
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(), // Do not show anything while the video is loading
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller
        .dispose(); // Dispose of the video controller when the widget is removed
  }
}
