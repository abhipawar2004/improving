import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/constants/constants.dart';

class DirectorVision extends StatefulWidget {
  const DirectorVision({super.key});

  @override
  State<DirectorVision> createState() => _DirectorVisionState();
}

class _DirectorVisionState extends State<DirectorVision> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "At Bansal and Son's Jewellers, our vision is to be the most trusted and beloved jewelry destination, renowned for our exquisite designs, exceptional craftsmanship, and unwavering commitment to customer delight.\n\nWe strive to create an unforgettable shopping experience, where every individual feels valued, inspired, and empowered to celebrate life's precious moments. Our mission is to help you find the perfect piece of jewelry that speaks to your unique style, personality, and love story.\n\nOur aim is to make Bansal and Son's Jewellers a nationwide store and then a worldwide store. We believe that jewelry is not just a possession, but a symbol of love, connection, and heritage.\n\nThank you for choosing Bansal and Son's Jewellers. We are honored to be a part of your journey and look forward to helping you shine brighter.",
              maxLines: isExpanded ? null : 5,
              overflow:
                  isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.sp, // Scaled font size
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20.h, // Scaled height for spacing
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kGray,
                  fixedSize: Size(150.w,
                      40.h), // Scaled button size for better responsiveness
                ),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? "Read Less" : "Read More",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 14.sp, // Scaled text size for button label
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
