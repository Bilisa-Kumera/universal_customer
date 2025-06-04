import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color borderColor;
  final double borderRadius;
  final Color fillColor;
  final double? width;
  final double? height;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.obscureText = false,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor = const Color(0xFFDDDDDD),
    this.borderRadius = 8.0,
    this.fillColor = Colors.white,
    this.width = 362,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: 1.5),
          ),
        ),
      ),
    );
  }
}
