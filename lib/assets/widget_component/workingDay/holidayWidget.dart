import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/workingday/publicHoliday.dart';

class HolidayWidget extends StatelessWidget {
  final List<PublicHoliday> holidays;
  final Function(DateTime) onHolidaySelected; // Callback
  const HolidayWidget({super.key, required this.holidays, required this.onHolidaySelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: holidays.length,
      itemBuilder: (context, index) {
        final holiday = holidays[index];
        return Card(
          margin: const EdgeInsets.all(10),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: ListTile(
            title: Text(holiday.name, style: const TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text(DateFormat('dd MMMM y').format(holiday.date)),
            onTap: () => onHolidaySelected(holiday.date),
          ),
        );
      },
    );
  }
}
