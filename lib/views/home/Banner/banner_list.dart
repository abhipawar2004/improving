import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/shimmers/banners_shimmer.dart';
import 'package:gehnamall/models/banner_models.dart';
import 'package:gehnamall/views/home/Banner/banner_widgets.dart';

import '../../../hooks/fetch_banner.dart';

class BannerList extends HookWidget {
  const BannerList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchBanner();
    List<BannerModel>? bannersList = hookResult.data;
    final isLoading = hookResult.isloading;
    final error = hookResult.error;

    // PageController for automatic page switching
    final PageController _pageController = usePageController();
    final int bannerCount = bannersList?.length ?? 0;

    // Start the timer to switch images every 2 seconds
    useEffect(() {
      final timer = Timer.periodic(Duration(seconds: 2), (timer) {
        if (_pageController.hasClients) {
          int nextPage = (_pageController.page!.toInt() + 1) % bannerCount;
          _pageController.animateToPage(
            nextPage,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      });

      return timer.cancel; // Cleanup the timer when the widget is disposed
    }, [bannerCount]);

    return Container(
      height: 180.h, // Responsive height with ScreenUtil
      child: isLoading
          ? const BannerShimmer()
          : (bannersList == null || bannersList.isEmpty)
              ? Center(
                  child: Text(
                    error != null
                        ? 'Failed to load banners. Please try again.'
                        : 'No banners available.',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp), // Responsive text size
                  ),
                )
              : PageView.builder(
                  controller: _pageController,
                  itemCount: bannersList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    BannerModel banner = bannersList[i];
                    return BannerWidget(banner: banner);
                  },
                ),
    );
  }
}
