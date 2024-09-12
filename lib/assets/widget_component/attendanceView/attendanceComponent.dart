import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
class AttendanceComponent extends StatelessWidget {
  final String? time;
  final int? timeDiff;
  final String status;

  const AttendanceComponent({super.key, this.time, this.timeDiff, required this.status});

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child:Text(
            '${(status == "in"? localization?.check_in : localization?.check_out)!}: ${time != null ? time?.substring(0,8) : ""}',
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 16),
          )
        ),
        Expanded(
          child: time == null ?
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.circle, size: 20, color: Colors.deepOrangeAccent),
              Text(" ${localization?.unchecked}",style: const TextStyle(fontSize: 16),)
            ],
          ) : timeDiff! >= 0
              ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.circle, size: 20, color: status == "in" ? Colors.green : Colors.red),
              Text(" ${localization?.early} ${durationToString(timeDiff!)}",style: const TextStyle(fontSize: 16),)
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.circle, size: 20, color: status == "in" ? Colors.red : Colors.green),
              Text(" ${localization?.late} ${durationToString(-timeDiff!)}",style: const TextStyle(fontSize: 16),),
            ],
          ),
        ),
      ],
    );
  }
}
String durationToString(int minutes) {
  var d = Duration(minutes:minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0]}h${parts[1].padLeft(2, '0')}m';
}