import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatelessWidget {
  late final String label;
  final void Function(String) onDateTimeChanged;

  DateTimePicker({super.key, required this.label,required this.onDateTimeChanged});

  DateTime? _selectedDateTime;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
      );

      if (pickedTime != null) {
        _selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        onDateTimeChanged(_formatDateTime(_selectedDateTime));
      }
    }
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'No date selected';
    final DateFormat dateFormat = DateFormat('dd MMM y HH:mm');
    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(Icons.calendar_today),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => _selectDateTime(context),
          child: const Text('Change', style: TextStyle(color: Colors.blue)),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}

