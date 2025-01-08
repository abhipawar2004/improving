import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

import 'package:gehnamall/constants/constants.dart';

class SlidderSecond extends StatefulWidget {
  const SlidderSecond({super.key});

  @override
  State<SlidderSecond> createState() => _SlidderSecondState();
}

class _SlidderSecondState extends State<SlidderSecond> {
  final PageController _pageController = PageController();
  final List<String> imagePaths = [
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img4.jpg',
    'assets/images/img5.jpg',
    'assets/images/img6.jpg',
  ];
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentIndex + 1) % imagePaths.length;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentIndex = nextPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider Section
        SizedBox(
          height: 250.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.fitHeight,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),
        // Indicator Section
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(imagePaths.length, (index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              width: _currentIndex == index ? 12.w : 8.w,
              height: _currentIndex == index ? 12.w : 8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? kDark : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}
