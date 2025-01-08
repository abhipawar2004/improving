import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/shimmers/banners_shimmer.dart';
import 'package:gehnamall/hooks/fetch_testimonial.dart';
import 'package:gehnamall/models/testimonial_models.dart';

import 'testimonial_widgets.dart';

class TestimonialList extends HookWidget {
  const TestimonialList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchTestimonial();
    List<TestimonialModels>? testimonialList = hookResult.data;
    final isLoading = hookResult.isloading;
    final error = hookResult.error;

    // PageController for automatic page switching
    final PageController _pageController = usePageController();
    final int testimonialCount = testimonialList?.length ?? 0;

    // Start the timer to switch images every 2 seconds
    useEffect(() {
      final timer = Timer.periodic(Duration(seconds: 2), (timer) {
        if (_pageController.hasClients) {
          int nextPage = (_pageController.page!.toInt() + 1) % testimonialCount;
          _pageController.animateToPage(
            nextPage,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      });

      return timer.cancel; // Cleanup the timer when the widget is disposed
    }, [testimonialCount]);

    return Container(
      height: 250.h, // Use ScreenUtil for adaptive height
      padding:
          EdgeInsets.symmetric(horizontal: 10.w), // Use ScreenUtil for padding
      child: isLoading
          ? const BannerShimmer()
          : (testimonialList == null || testimonialList.isEmpty)
              ? Center(
                  child: Text(
                    error != null
                        ? 'Failed to load Testimonial. Please try again.'
                        : 'No Testimonial available.',
                    style: TextStyle(
                        color: Colors.grey, fontSize: 14.sp), // Scale font size
                  ),
                )
              : PageView.builder(
                  controller: _pageController,
                  itemCount: testimonialList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    TestimonialModels testimonial = testimonialList[i];
                    return TestimonialWidget(testimonial: testimonial);
                  },
                ),
    );
  }
}
