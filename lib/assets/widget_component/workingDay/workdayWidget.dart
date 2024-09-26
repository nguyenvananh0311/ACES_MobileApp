import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/workingday/workday.dart';


class WorkdayWidget extends StatelessWidget {

  final List<WorkDay> workdays;

  const WorkdayWidget({super.key, required this.workdays});

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return ListView.builder(
      itemCount: workdays.length,
      itemBuilder: (context, index) {
        final workday = workdays[index];
        return Card(
          margin: const EdgeInsets.all(10),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          color: workday.status ? const Color(0xF3F3F3FF) : const Color(0xFFDED9D9),
          child: ListTile(
            leading: SizedBox(
              width: 70,
              child: Text(workday.dayName.substring(0,3), style: const TextStyle(fontSize: 18),),
            ),
            title: Text(localization!.workingTime, style: TextStyle(fontWeight: FontWeight.bold),)  ,
            subtitle:
            workday.status ?
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(workday.morCheckInTime != null)
                    Row(
                      children: [
                        const Icon(Icons.circle_rounded, size: 10,color: Colors.blue,),
                        const SizedBox(width: 5,),
                        Text('${workday.morCheckInTime} - ${workday.morCheckOutTime}'),
                      ],
                    ),
                    if(workday.aftCheckInTime != null)
                    Row(
                      children: [
                        const Icon(Icons.circle_rounded, size: 10,color: Colors.blue,),
                        const SizedBox(width: 5,),
                        Text('${workday.aftCheckInTime} - ${workday.aftCheckOutTime}')
                      ],
                    )
                  ],
                )
                  :  Row(
              children: [
                const Icon(Icons.circle_rounded, size: 10,color: Colors.blue,),
                const SizedBox(width: 5,),
                Text(localization.dayOff, style: const TextStyle(color: Colors.black),)
              ],
            ),
          ),
        );
      },
    );
  }
}
