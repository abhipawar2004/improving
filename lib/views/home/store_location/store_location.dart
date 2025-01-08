import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreLocation extends StatefulWidget {
  const StoreLocation({super.key});

  @override
  State<StoreLocation> createState() => _StoreLocationState();
}

class _StoreLocationState extends State<StoreLocation> {
  // Define your Google Maps URL
  final String mapUrl =
      'https://www.google.com/maps/place/Bansal+%26+sons+Jewellers/@28.6574758,77.2288831,17z/data=!3m1!4b1!4m6!3m5!1s0x390cfd2a28dbc9ef:0x30322c1d46e4709!8m2!3d28.6574758!4d77.2288831!16s%2Fg%2F1pzr0nf9x?entry=ttu';

  // Function to open the URL
  void _openMap() async {
    final Uri url = Uri.parse(mapUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $mapUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: SizedBox(
        height: 220.h,
        width: double.infinity,
        child: InkWell(
          onTap: _openMap,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  'assets/images/maplocationshop.png',
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
