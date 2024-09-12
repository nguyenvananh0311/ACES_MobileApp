import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const IconContainer({super.key, required this.icon, required this.iconColor , required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Icon(icon, size: 20.0, color: iconColor),
    );
  }
}
