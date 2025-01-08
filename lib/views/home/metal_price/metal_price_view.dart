// views/metal_price_view.dart
import 'package:flutter/material.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/controllers/metal_price_controller.dart';
import 'package:gehnamall/models/metal_price.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MetalPriceView extends StatelessWidget {
  final MetalPriceController controller = Get.put(MetalPriceController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(360, 690)); // Set design size

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3D3),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 200.h),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'Gold And Silver Market Prices',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Live Prices Updated Regularly',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Stay updated with the latest market trends for gold and silver. '
                      'Track daily price fluctuations, historical data, and forecasts to '
                      'make informed investment decisions.',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    _buildTableHeader(),
                    ...controller.prices
                        .map((metal) => _buildPriceRow(metal))
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: kDark,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHeaderCell("METAL'S"),
          _buildHeaderCell('24K'),
          _buildHeaderCell('22K'),
          _buildHeaderCell('18K'),
          _buildHeaderCell('14K'),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String title) {
    return Expanded(
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPriceRow(MetalPrice metal) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 8.h), // Minimized vertical padding
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.brown.shade200, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildRowCell(metal.metalName),
          _buildRowCell(metal.price24K),
          _buildRowCell(metal.price22K),
          _buildRowCell(metal.price18K),
          _buildRowCell(metal.price14K),
        ],
      ),
    );
  }

  Widget _buildRowCell(String content) {
    return Expanded(
      child: Text(
        content,
        style: TextStyle(
          fontSize: 12.sp,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
