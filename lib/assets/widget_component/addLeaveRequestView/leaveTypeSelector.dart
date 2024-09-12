import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class LeaveTypeSelector extends StatelessWidget {
  final String selectedLeaveType;
  final ValueChanged<String?> onChanged;
  final String title;

  const LeaveTypeSelector({
    super.key,
    required this.selectedLeaveType,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Radio<String>(
              value: "Morning",
              groupValue: selectedLeaveType,
              onChanged: onChanged,
            ),
            Text(localization?.morning ?? "Morning"),
            const SizedBox(width: 8,),
            Radio<String>(
              value: "Afternoon",
              groupValue: selectedLeaveType,
              onChanged: onChanged,
            ),
            Text(localization?.afternoon ?? "Afternoon"),
          ],
        )
      ],
    );
  }
}
