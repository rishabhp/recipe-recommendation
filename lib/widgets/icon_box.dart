import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double radius;
  final double iconSize;

  const IconBox({
    super.key,
    required this.icon,
    this.backgroundColor = const Color(0xFFFFF3E0),
    this.iconColor = Colors.orange,
    this.size = 48,
    this.radius = 14,
    this.iconSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Icon(icon, color: iconColor, size: iconSize,),
    );
  }
}
