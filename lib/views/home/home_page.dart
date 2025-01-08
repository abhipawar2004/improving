import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/custom_container.dart';
import 'package:gehnamall/common/custome_appbar.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/views/home/Banner/banner_list.dart';
import 'package:gehnamall/views/home/FollowButtons/followtabs.dart';
import 'package:gehnamall/views/home/Gifting/gifting_list.dart';
import 'package:gehnamall/views/home/Testimonial/testimonial_list.dart';
import 'package:gehnamall/views/home/about_company/about_company.dart';
import 'package:gehnamall/views/home/category/category_list.dart';
import 'package:gehnamall/views/home/connect/connect.dart';
import 'package:gehnamall/views/home/director_vision/director_vision.dart';
import 'package:gehnamall/views/home/feedback/feedback.dart';
import 'package:gehnamall/views/home/lightCategories/light_category_list.dart';
import 'package:gehnamall/views/home/occasion/occasion_list.dart';
import 'package:gehnamall/views/home/slidder_one/slidder_second.dart';
import 'package:gehnamall/views/home/soulmate/soulmate_list.dart';
import 'package:gehnamall/views/home/store_location/store_location.dart';

import 'detail/detail.dart';
import 'slidder_one/slidder_one.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDark,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.h), // Adjust height
        child: const CustomeAppbar(),
      ),
      body: SafeArea(
        child: CustomContainer(
          containerContent: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LightCategoryList(),
                BannerList(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.center,
                      heightFactor:
                          0.7, // Adjust this value to crop more or less
                      child: Image.asset(
                        'assets/images/ansurence.png',
                        fit: BoxFit.contain,
                        width: double.maxFinite,
                        height: 120.h,
                      ),
                    ),
                  ),
                ),
                CategoriesList(),
                SizedBox(height: 10.h),
                _sectionTitle("Gifting Guide"),
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    "🎁 Find the Perfect Present",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cursive',
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: kDark,
                    ),
                  ),
                ),
                GiftingList(),
                _sectionTitle("Gleam Follow and Shine!"),
                FollowTabs(),
                SizedBox(height: 15.h),
                _sectionTitle("For Yours Special"),
                SoulmateList(),
                BannerOne(),
                _sectionTitle("Shop For Occasions"),
                OccasionList(),
                _sectionTitle("Testimonial"),
                TestimonialList(),
                SizedBox(height: 20.h),
                _sectionTitle("Director's Vision"),
                SizedBox(height: 20.h),
                DirectorVision(),
                SizedBox(height: 20.h),
                _sectionTitle("About Company"),
                SizedBox(height: 20.h),
                AboutCompany(),
                SizedBox(height: 20.h),
                SlidderSecond(),
                SizedBox(height: 20.h),
                _sectionTitle("Store Location"),
                StoreLocation(),
                SizedBox(height: 20.h),
                _sectionTitle("Your Feedback, Our Treasure!"),
                YourFeedback(),
                SizedBox(height: 25.h),
                _sectionTitle("Connect with us"),
                ConnectWithUs(),
                SizedBox(height: 20.h),
                DetailScreen(),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w), // Adjust padding
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey,
              thickness: 1,
              endIndent: 8.w, // Spacing to the text
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20.sp,
              color: kDark,
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 8.w, // Spacing to the text
            ),
          ),
        ],
      ),
    );
  }
}
