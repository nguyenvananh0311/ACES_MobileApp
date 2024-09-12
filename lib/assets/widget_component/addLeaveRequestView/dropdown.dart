import 'package:flutter/material.dart';

class DropdownSelector extends StatelessWidget {
  final Widget label;
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String?> onChanged;

  const DropdownSelector({super.key, required this.label, required this.items, required this.selectedValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        label,
        const Spacer(),
        DropdownButton<String>(
          value: selectedValue,
          icon: const Icon(Icons.arrow_drop_down),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
