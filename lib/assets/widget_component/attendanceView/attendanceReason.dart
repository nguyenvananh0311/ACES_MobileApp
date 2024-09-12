import 'package:flutter/material.dart';

import '../../../activities/scanQRcode.dart';
import '../../../l10n/app_localizations.dart';

void showReasonDialog(BuildContext context, TextEditingController reasonController, Function callback,
    int employeeId, String companyId, bool isLate, String branch) {
  var localization = AppLocalizations.of(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(localization!.noteTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(localization.submitNotePrompt),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(
                hintText: localization.noteHint,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  TextButton(
                    onPressed: () {
                      reasonController.text = localization.sorryLate;
                    },
                    child: Text(localization.sorryLate),
                  ),
                  TextButton(
                    onPressed: () {
                      reasonController.text = localization.iAmSick;
                    },
                    child: Text(localization.iAmSick),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanQRScreen(employeeId: employeeId, companyId: companyId, reason: reasonController.text,branch: branch, )),
              ).then((result) {
                if (result == 'success') {
                  callback(); // Gọi callback để tải lại dữ liệu
                }
              });
            },
            child: Text(localization.doneButton),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanQRScreen(employeeId: employeeId, companyId: companyId,branch: branch )),
              ).then((result) {
                if (result == 'success') {
                  callback(); // Gọi callback để tải lại dữ liệu
                }
              });
            },
            child: Text(localization.skipButton),
          ),
        ],
      );
    },
  );
}

void showErrorDialog(BuildContext context) {
  var localization = AppLocalizations.of(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(localization!.errorTitle),
        content: Text(localization.locationError),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
