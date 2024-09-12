import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileUpload extends StatelessWidget {
  final PlatformFile? pickedFile;
  final bool isLoading;
  final String fileName;
  final ValueChanged<PlatformFile> onFileSelected;

  const FileUpload({super.key, 
    required this.isLoading,
    required this.onFileSelected,
    this.pickedFile,
    required this.fileName,
  });

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      // String base64Image = await _convertToBase64(file);
      // Lưu hoặc xử lý base64Image tùy theo yêu cầu của bạn
      onFileSelected(file);
    }
    else {
      print("FilePicker canceled");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => _pickFile(context),
                icon: const Icon(Icons.cloud_upload, color: Colors.blue),
              ),
              const SizedBox(width: 10),
              Text(fileName),
            ],
          ),
        ],
      ),
    );
  }
}
