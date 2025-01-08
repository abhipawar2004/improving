import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final double? fontSize;
  final Color? textColor;

  CustomButton({
    required this.label,
    required this.onPressed,
    this.width,
    this.height,
    this.color,
    this.fontSize,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
