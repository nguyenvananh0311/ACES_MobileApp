import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class AttendanceCard extends StatelessWidget {
  final String title;
  final String? time;
  final int? timeDiff;
  final String status;
  const AttendanceCard({super.key, 
    required this.title,
    this.time,
    this.timeDiff,
    required this.status
  });

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: ListTile(
        leading:    Icon(status == "in" ? Icons.arrow_circle_right_outlined : Icons.arrow_circle_left_outlined, color: Colors.blue, ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text((time == null || time == "null") ? localization!.unchecked : time.toString().substring(0,8), style: const TextStyle(fontWeight: FontWeight.bold)),
            (time != null && time != "null")?
            timeDiff! >= 0
                ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.circle, size: 10, color: status == "in" ? Colors.green : Colors.red),
                Text(" ${(status == "in"? localization?.check_in : localization?.check_out)!}: ${localization?.early} ${durationToString(timeDiff!)}")
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.circle, size: 10, color: status == "in" ? Colors.red : Colors.green),
                Text(" ${(status == "in"? localization?.check_in : localization?.check_out)!}: ${localization?.late} ${durationToString(-timeDiff!)}"),
              ],
            )
            : const SizedBox(width: 0,),
          ],
        ),
      ),
    );
  }
}

String durationToString(int minutes) {
  var d = Duration(minutes:minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0]}h${parts[1].padLeft(2, '0')}m';
}