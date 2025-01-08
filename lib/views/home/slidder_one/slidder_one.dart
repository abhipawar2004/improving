import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerOne extends StatefulWidget {
  @override
  State<BannerOne> createState() => _BannerOneState();
}

class _BannerOneState extends State<BannerOne> {
  final PageController _pageController = PageController();
  final List<String> imagePaths = [
    'assets/images/b1.png',
    'assets/images/b2.png',
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
        SizedBox(
          height: 250.h, // Use adaptive height
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
                margin:
                    EdgeInsets.symmetric(horizontal: 10.w), // Adapted margin
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(10.r), // Adapted border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 5.r, // Adapted blur radius
                      offset: Offset(0, 3.h), // Adapted offset
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10.r), // Adapted border radius
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.fitWidth,
                    width: double.infinity, // Full width for better scaling
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h), // Adaptive spacing
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(imagePaths.length, (index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 5.w), // Adaptive spacing
              width: _currentIndex == index ? 12.w : 8.w, // Adaptive size
              height: _currentIndex == index ? 12.h : 8.h, // Adaptive size
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.red : Colors.white,
              ),
            );
          }),
        ),
      ],
    );
  }
}
