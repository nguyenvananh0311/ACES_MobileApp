import 'package:flutter/material.dart';

class TextIconContainer extends StatelessWidget {
  final IconData? icon;
  String? text;
  final Color? textColor;
  final Color? iconColor;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  TextIconContainer({super.key,  this.icon, required this.backgroundColor, this.iconColor, this.text, this.onPressed, this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if(icon !=null)
                Icon(icon, size: 20.0, color: iconColor ?? Colors.black),
              if (text != null) // Kiểm tra xem text có giá trị không
                const SizedBox(width: 8.0), // Thêm khoảng cách giữa icon và text
              if (text != null)
                Text(text!, style: TextStyle(fontSize: 16.0, fontFamily: 'Roboto', fontWeight:FontWeight.normal, color: textColor ?? Colors.black ),)
            ],
          )
      ),
    );
  }
}
