// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gehnamall/common/app_style.dart';
// import 'package:gehnamall/common/reusable_text.dart';
// import 'package:gehnamall/constants/constants.dart';
// import 'package:gehnamall/views/cart/cart_page.dart';
// import 'package:gehnamall/views/entrypoint.dart';
// import 'package:gehnamall/views/home/TermsAndConditionsScreen/TermsAndConditionsScreen.dart';
// import 'package:gehnamall/views/home/category_for_menu/category_menu/CategoriesListForAppBar.dart';
// import 'package:gehnamall/views/home/metal_price/metal_price_view.dart';
// import 'package:gehnamall/views/profile/profile_page.dart';
// import 'package:gehnamall/views/whatsapp/chat_page.dart';

// class CustomeAppbar extends StatelessWidget {
//   const CustomeAppbar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//       height: 100.h,
//       width: double.infinity,
//       color: kDark,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Menu Icon
//           IconButton(
//             icon: Icon(Icons.menu, color: kOffWhite, size: 24.sp),
//             onPressed: () {
//               _showMenuDialog(context);
//             },
//           ),
//           // Title Text
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(left: 8.w),
//               child: ReusableText(
//                 text: "BANSAL & SONS JEWELLERS PVT LTD.",
//                 style: appStyle(13, kOffWhite, FontWeight.w600),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showMenuDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierColor: Colors.black.withOpacity(0.5),
//       builder: (BuildContext context) {
//         return Align(
//           alignment: Alignment.centerLeft,
//           child: Material(
//             color: Colors.transparent,
//             child: Container(
//               width: 0.7.sw,
//               constraints: BoxConstraints(maxHeight: 0.9.sh),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(20.r),
//                   bottomRight: Radius.circular(20.r),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     spreadRadius: 5,
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 12.w, top: 20.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildMenuItem(
//                         context,
//                         title: "Home",
//                         onTap: () => _navigateTo(context, MainScreen()),
//                       ),
//                       _buildMenuItem(
//                         context,
//                         title: "Whatsapp",
//                         onTap: () => _navigateTo(context, const ChatPage()),
//                       ),
//                       _buildMenuItem(
//                         context,
//                         title: "WishList",
//                         onTap: () => _navigateTo(context, CartPage()),
//                       ),
//                       Container(
//                         width: 0.7.sw, // 70% of screen width
//                         constraints: BoxConstraints(
//                             maxHeight: 0.8.sh), // 80% of screen height
//                         child: SingleChildScrollView(
//                           child: CategoriesListForAppBar(),
//                         ),
//                       ),
//                       _buildMenuItem(
//                         context,
//                         title: "Profile",
//                         onTap: () => _navigateTo(context, ProfilePage()),
//                       ),
//                       _buildMenuItem(
//                         context,
//                         title: "Metal Price",
//                         onTap: () => _navigateTo(context, MetalPriceView()),
//                       ),
//                       _buildMenuItem(
//                         context,
//                         title: "Terms & Conditions",
//                         onTap: () =>
//                             _navigateTo(context, TermsAndConditionsScreen()),
//                       ),
//                       SizedBox(height: 100.h),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildMenuItem(BuildContext context,
//       {required String title, required VoidCallback onTap}) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       title: Text(
//         title,
//         style: appStyle(15, Colors.black, FontWeight.w500),
//         overflow: TextOverflow.ellipsis,
//         maxLines: 1,
//       ),
//       onTap: () {
//         Navigator.pop(context);
//         onTap();
//       },
//     );
//   }

//   void _navigateTo(BuildContext context, Widget page) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => page),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Add GetX import
import 'package:gehnamall/common/app_style.dart';
import 'package:gehnamall/common/reusable_text.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/views/cart/cart_page.dart';
import 'package:gehnamall/views/entrypoint.dart';
import 'package:gehnamall/views/home/TermsAndConditionsScreen/TermsAndConditionsScreen.dart';
import 'package:gehnamall/views/home/category_for_menu/category_menu/CategoriesListForAppBar.dart';
import 'package:gehnamall/views/home/metal_price/metal_price_view.dart';
import 'package:gehnamall/views/profile/profile_page.dart';
import 'package:gehnamall/views/whatsapp/chat_page.dart';

class CustomeAppbar extends StatelessWidget {
  const CustomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      height: 100.h,
      width: double.infinity,
      color: kDark,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Icon
          IconButton(
            icon: Icon(Icons.menu, color: kOffWhite, size: 24.sp),
            onPressed: () {
              _showMenuDialog(context);
            },
          ),
          // Title Text
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: ReusableText(
                text: "BANSAL & SONS JEWELLERS PVT LTD.",
                style: appStyle(13, kOffWhite, FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMenuDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 0.7.sw,
              constraints: BoxConstraints(maxHeight: 0.9.sh),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w, top: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMenuItem(
                        context,
                        title: "Home",
                        onTap: () => _navigateTo(context, MainScreen()),
                      ),
                      _buildMenuItem(
                        context,
                        title: "Whatsapp",
                        onTap: () => _navigateTo(context, const ChatPage()),
                      ),
                      _buildMenuItem(
                        context,
                        title: "WishList",
                        onTap: () => _navigateTo(context, CartPage()),
                      ),
                      // Use GetX to manage CategoriesListForAppBar lifecycle
                      GetBuilder<CategoriesController>(
                        init: CategoriesController(),
                        builder: (controller) {
                          return Container(
                            width: 0.7.sw,
                            constraints: BoxConstraints(maxHeight: 0.8.sh),
                            child: SingleChildScrollView(
                              child: CategoriesListForAppBar(),
                            ),
                          );
                        },
                      ),
                      _buildMenuItem(
                        context,
                        title: "Profile",
                        onTap: () => _navigateTo(context, ProfilePage()),
                      ),
                      _buildMenuItem(
                        context,
                        title: "Metal Price",
                        onTap: () => _navigateTo(context, MetalPriceView()),
                      ),
                      _buildMenuItem(
                        context,
                        title: "Terms & Conditions",
                        onTap: () =>
                            _navigateTo(context, TermsAndConditionsScreen()),
                      ),
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: appStyle(15, Colors.black, FontWeight.w500),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class CategoriesController extends GetxController {
  // Manage CategoriesListForAppBar lifecycle with GetX

  @override
  void onClose() {
    // Clean up and dispose resources
    super.onClose();
  }
}
