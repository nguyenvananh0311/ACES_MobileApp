import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class LeaveItem extends StatelessWidget {
  final String date;
  final String status;
  final String description;
  final double duration;
  final VoidCallback onTap;

  const LeaveItem({super.key, 
    required this.date,
    required this.status,
    required this.description,
    required this.duration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return ListTile(
      leading: Icon(status == "Approved"? Icons.approval : status == "Rejected" ? Icons.free_cancellation : Icons.pending_actions,
          color: status == "Approved"? Colors.green : status == "Rejected" ? Colors.red : Colors.orange),
      title: Text(
        "$date | ${localization?.duration}: $duration",
        style: const TextStyle(fontSize: 14),
      ),
      subtitle: Text("${localization?.reason}: $description"),
      trailing: Text(
        status,
        style: TextStyle(color: status == "Approved"? Colors.green : status == "Rejected" ? Colors.red : Colors.orange, fontSize: 12),
      ),
      onTap: onTap,
    );
  }
}
