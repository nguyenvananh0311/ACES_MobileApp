import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import 'filePicker.dart';

class ReasonField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<PlatformFile> onFileSelected;
  final String fileName;
  const ReasonField({super.key, required this.controller, required this.onFileSelected, required this.fileName});

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Row(
              children: [
                Text(localization!.reason, style: const TextStyle(fontWeight: FontWeight.bold),),
                const Text('*',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),)
              ],
            ),
            FileUpload(
              isLoading: false,
              onFileSelected:(PlatformFile file){
                onFileSelected(file);
              },
              fileName: fileName
            ),
          ],
        ),
        TextField(
          controller: controller,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: localization.reasonPlaceholder,
            border: const OutlineInputBorder(),
            // suffixIcon: Icon(Icons.cloud_upload),
          ),
        ),
      ],
    );
  }
}
