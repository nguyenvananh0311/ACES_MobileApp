import 'package:flutter/material.dart';

class LeaveDetailItem extends StatelessWidget {
  final String label;
  final String description;

  const LeaveDetailItem({super.key,
    required this.label,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            children: <Widget>[
              Text("$label :", style: const TextStyle(fontWeight: FontWeight.bold),),
              const Spacer(),
              Text(description, style: const TextStyle(fontWeight: FontWeight.bold),),
            ]
        ),
        const SizedBox(height: 16,)
      ],
    );
  }
}
