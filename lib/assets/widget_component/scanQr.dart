import 'dart:io';
import 'package:ems/assets/widget_component/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart' as ml_kit;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../l10n/app_localizations.dart';


class ScanQRWidget extends StatefulWidget {
  final Function handle;
  final bool isProcessing;
  final String? branch;
  const ScanQRWidget({super.key, required this.handle, required this.isProcessing, this.branch});

  @override
  _ScanLoginQRState createState() => _ScanLoginQRState();
}

class _ScanLoginQRState extends State<ScanQRWidget> {
  String companyId = "";
  int employeeId = 0;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isProcessing = false;
  final ml_kit.BarcodeScanner barcodeScanner = ml_kit.BarcodeScanner();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isProcessing = widget.isProcessing;
  }
  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
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
                setState(() {
                  isProcessing = false;
                });
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    isProcessing = widget.isProcessing;
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: QRView(
            key: qrKey,
            onQRViewCreated:  _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
        ),
        Positioned(
            bottom: 20,
            left: 50,
            right: 50,
            child: Card(
              margin: const EdgeInsets.all(20),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              shadowColor: Colors.black,
              child: IconButton(
                icon: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Icon(Icons.upload_file, color: Colors.blue, size: 30,),
                    SizedBox(width: 10,),
                    Text("Upload Image", style: TextStyle(fontSize: 20, color: Colors.blue),),
                    Spacer()
                  ],
                ),
                onPressed: _pickFile,
              ),
            )
        ),
      ],
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      final File file = File(result.files.single.path!);
      await _scanBarcode(file);
    }
  }
  Future<void> _scanBarcode(File file) async {
    isProcessing = true;

    final ml_kit.InputImage inputImage = ml_kit.InputImage.fromFile(file);
    final List<ml_kit.Barcode> barcodes = await barcodeScanner.processImage(inputImage);

    if (barcodes.isNotEmpty) {
      final String code = barcodes.first.displayValue!;
      if(widget.branch == null || (widget.branch != null && code == widget.branch.toString())){
        await widget.handle(code);
      }
      else if(widget.branch != null && !(code == widget.branch.toString())){
        errorToast("Invalid QR Code");
        isProcessing = false;
      }
    } else {
      errorToast(AppLocalizations.of(context)!.errorTitle);
      isProcessing = false;
    }
  }
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (isProcessing) return;
      result = scanData;
      isProcessing = true;
      var code = result!.code;
      print(code);
      if(code != null && isProcessing){
        if(widget.branch == null || (widget.branch != null && code == widget.branch.toString())){
          await widget.handle(code);
        }
        else if(widget.branch != null && !(code == widget.branch.toString())){
          errorToast("Invalid QR Code");
          isProcessing = false;
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.pauseCamera();
    controller?.dispose();
    super.dispose();
  }
}
