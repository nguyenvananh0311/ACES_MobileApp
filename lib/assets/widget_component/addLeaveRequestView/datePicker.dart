import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onDateSelected;

  const DatePicker({super.key, required this.label, required this.controller, required this.onDateSelected});

  Future<void> _selectDate(BuildContext context) async {
    String selectedDateLabel;
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      controller.text = DateFormat('EEE dd MMMM y').format(selectedDate);
      selectedDateLabel = DateFormat('EEE dd MMMM y').format(selectedDate);
      onDateSelected(selectedDateLabel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(Icons.calendar_today),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold),),
        const Spacer(),
        TextButton(
          onPressed: () => _selectDate(context),
          child: const Text('Change', style: TextStyle(color: Colors.blue)),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
