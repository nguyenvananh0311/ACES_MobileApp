import 'package:flutter/material.dart';

class CustomAppBarScreen extends StatefulWidget implements PreferredSizeWidget{
  final String title;
  final IconData? icon;
  final Widget? actions;
  final bool? isBack;
  CustomAppBarScreen({super.key, required this.title,this.icon, this.actions, this.isBack});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}

class _CustomAppBarState extends State<CustomAppBarScreen> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.lightBlueAccent, // Màu đầu
            Colors.lightBlue,  // Màu cuối
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child:  Column(
        children: [
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if(widget.isBack != null && widget.isBack!)
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  if(widget.icon != null)
                    Icon(widget.icon!, color: Colors.white, size: 30),
                  const SizedBox(width: 8.0),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if(widget.actions != null)
                widget.actions!,
            ],
          )),
          const SizedBox(height: 10,),
          Expanded(child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
          ))
        ],
      )
    );
  }
}
