
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../assets/widget_component/scanQr.dart';
import '../assets/widget_component/toast.dart';
import '../l10n/app_localizations.dart';
import '../models/attendance/attendanceBody.dart';
import '../services/apiService.dart';

class ScanQRScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  final String branch;
  final String? reason;
  final String? requestId;
  const ScanQRScreen({super.key, required this.companyId, required this.employeeId, this.reason, this.requestId,required this.branch});

  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQRScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isProcessing = false;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization!.qrCodeScanner),
      ),
      body: ScanQRWidget(handle: _handle,isProcessing: isProcessing, branch: widget.branch,)
    );
  }
  Future<void> _handle(String code) async {
    final localization = AppLocalizations.of(context)!;
    AttendanceBody request = AttendanceBody(
      employeeId: widget.employeeId,
      qRCode: code,
      note: widget.reason,
      requestId: widget.requestId,
    );
    var response = widget.requestId != null
        ? await ApiService().addOTCheckIn(request, widget.companyId)
        : await ApiService().addAttendance(request, widget.companyId);

    if (response.isSuccess) {
      successToast(localization.attendanceSuccessful);
      setState(() {
        isProcessing = true;
      });
      if (Navigator.canPop(context)) {
        Navigator.pop(context, 'success');
      } else {
        print("No screens to pop");
      }
    } else {
      setState(() {
        isProcessing = false;
      });
      errorToast("${response.message}. ${localization.pleaseTryAgainOrContactYourManager}");
    }
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
