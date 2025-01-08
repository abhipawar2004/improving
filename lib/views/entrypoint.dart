// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/controllers/tab_index_contoller.dart';
import 'package:gehnamall/views/cart/cart_page.dart';
import 'package:gehnamall/views/home/home_page.dart';
import 'package:gehnamall/views/profile/profile_page.dart';
import 'package:gehnamall/views/whatsapp/chat_page.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> pageList = [
    const HomePage(),
    const ChatPage(),
    CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kDark, // Set the status bar color
      statusBarIconBrightness:
          Brightness.light, // Adjust icons for light/dark mode
    ));

    final controller = Get.put(TabIndexContoller());

    return Obx(() => Scaffold(
          body: Stack(
            children: [
              // Display the current page
              pageList[controller.tabIndex],

              // Bottom navigation bar
              Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                  data: Theme.of(context).copyWith(canvasColor: kOffWhite),
                  child: BottomNavigationBar(
                    showSelectedLabels: true,
                    showUnselectedLabels: false,
                    selectedItemColor: Colors.black,
                    unselectedIconTheme: IconThemeData(
                      color: Colors.black.withOpacity(0.6),
                      size: 22.sp, // Dynamic size
                    ),
                    selectedIconTheme: IconThemeData(
                      color: kDark,
                      size: 26.sp, // Dynamic size
                    ),
                    onTap: (value) {
                      controller.setTabIndex = value;
                    },
                    currentIndex: controller.tabIndex,
                    items: [
                      BottomNavigationBarItem(
                        icon: controller.tabIndex == 0
                            ? const Icon(AntDesign.appstore1)
                            : const Icon(AntDesign.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          'assets/icons/whatsapp.png',
                          height: 24.h, // Dynamic height
                          width: 24.w, // Dynamic width
                        ),
                        label: 'Whatsapp',
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                        label: 'Cart',
                      ),
                      BottomNavigationBarItem(
                        icon: controller.tabIndex == 3
                            ? const Icon(FontAwesome.user_circle)
                            : const Icon(FontAwesome.user_circle_o),
                        label: 'Profile',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
