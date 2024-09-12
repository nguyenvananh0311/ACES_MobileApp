import 'package:flutter/material.dart';

import '../../background/icon_container.dart';
class OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color iconColor;
  final Color iconBackgroundColor;

  const OptionTile({super.key, required this.icon, required this.title, required this.subtitle, required this.onTap,required this.iconColor, required this.iconBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: IconContainer(icon: icon,backgroundColor: iconBackgroundColor,iconColor: iconColor,),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const IconContainer(icon: Icons.navigate_next,backgroundColor: Colors.white54,iconColor: Colors.blue,),
        onTap: onTap,
      ),
    );
  }
}
