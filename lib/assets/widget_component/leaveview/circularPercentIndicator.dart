import 'package:flutter/material.dart';

class CircularPercentIndicator extends StatelessWidget {
  final double radius;
  final double lineWidth;
  final double percent;
  final Widget center;
  final Color progressColor;

  const CircularPercentIndicator({super.key, 
    required this.radius,
    required this.lineWidth,
    required this.percent,
    required this.center,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius,
      height: radius,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: radius,
            height: radius,
            child: CircularProgressIndicator(
              value: percent,
              strokeWidth: lineWidth,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              backgroundColor: Colors.grey[300],
            ),
          ),
          center,
        ],
      ),
    );
  }
}
