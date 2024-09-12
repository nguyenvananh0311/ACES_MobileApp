import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HomeAppBarScreen extends StatefulWidget implements PreferredSizeWidget{
  final String title;
  final Widget iconButton;
  final String? name;

  HomeAppBarScreen({super.key,required this.name, required this.title, required this.iconButton });

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(140.0);
}

class _HomeAppBarState extends State<HomeAppBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.lightBlueAccent, // Màu đầu
            Colors.lightBlue,  // Màu cuối
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // color: Colors.pinkAccent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 20.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white, size: 30),
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
                widget.iconButton,
              ],
            ),
            const SizedBox(height: 15.0),
             Row(
                children: [
                  const Text("Hello, ", style: TextStyle(color: Colors.white, fontSize: 25),),
                  Text(widget.name == null ? '' : widget.name.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
                ])

        //     Container(
        //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //       decoration: BoxDecoration(
        //         color: Colors.white.withOpacity(0.2),
        //         borderRadius: BorderRadius.circular(15.0),
        //       ),
        //       child:
        //
        //           // Expanded(
        //           //   child: TextField(
        //           //     decoration: InputDecoration(
        //           //       hintText: 'Search',
        //           //       border: InputBorder.none,
        //           //       hintStyle: TextStyle(color: Colors.white),
        //           //     ),
        //           //     style: TextStyle(color: Colors.white),
        //           //   ),
        //           // ),
        //           // Icon(Icons.search, color: Colors.white),
        //         ],
        //       ),
        //     ),
          ],
        ),
      ),
    );
  }


}