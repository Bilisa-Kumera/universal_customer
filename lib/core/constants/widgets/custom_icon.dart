import 'package:flutter/material.dart';

class CustomIconBox extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final double size;
  final double radius;
  final Color iconColor;
  final VoidCallback? onTap;

  const CustomIconBox({
    super.key,
    required this.icon,
    this.backgroundColor = const Color(0xFFFFF1B1),
    this.size = 34,
    this.radius = 4,
    this.iconColor = Colors.black,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Icon(icon, size: size * 0.5, color: iconColor),
        ),
      ),
    );
  }
}
