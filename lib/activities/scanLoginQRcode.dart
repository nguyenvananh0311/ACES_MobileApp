import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../assets/widget_component/scanQr.dart';
import '../assets/widget_component/toast.dart';
import '../l10n/app_localizations.dart';
import '../mainscreen.dart';
import '../models/login/login.dart';
import '../services/apiService.dart';
import '../services/firebaseService.dart';

class ScanLoginQRScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  const ScanLoginQRScreen({super.key, required this.onLocaleChange,});

  @override
  _ScanLoginQRState createState() => _ScanLoginQRState();
}

class _ScanLoginQRState extends State<ScanLoginQRScreen> {
  String companyId = "";
  int employeeId = 0;
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
      body: ScanQRWidget(handle: _handle,isProcessing: isProcessing,)
    );
  }

  Future<void> _handle(String code) async {
    var response = await ApiService().fetchMobileLogin(code);
    if (response.isSuccess) {
      successToast(AppLocalizations.of(context)!.logInSuccessfully);
      setState(() {
        isProcessing = true;
      });
      MobileLogin? mobileLogin = response.response;

      // Lưu thông tin vào SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('companyId', mobileLogin!.companyId);
      await prefs.setString('name', mobileLogin.name == null ? "": mobileLogin.name.toString());
      await prefs.setInt('employeeId', mobileLogin.id);
      FirebaseService().initializeFirebaseMessaging(mobileLogin.id, mobileLogin.companyId);
      controller?.pauseCamera();
      controller?.dispose();
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(
            companyId: mobileLogin.companyId,
            employeeId: mobileLogin.id,
            onLocaleChange: widget.onLocaleChange,
            employeeName: mobileLogin.name,
          ),
        ),
      );
    } else {
      setState(() {
        isProcessing = false;
      });

      errorToast("${AppLocalizations.of(context)!.failedToLogIn}: ${response.message}");
    }
  }
  @override
  void dispose() {
    controller?.pauseCamera();
    controller?.dispose();
    super.dispose();
  }
}
