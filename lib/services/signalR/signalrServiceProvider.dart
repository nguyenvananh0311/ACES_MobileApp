import 'package:ems/services/signalR/signalrService.dart';
import 'package:flutter/foundation.dart';

import '../apiService.dart';
import '../notification/localNotificationService.dart';


class SignalRServiceProvider extends ChangeNotifier {
  final SignalRService _signalRService = SignalRService();
  String _message = 'No message received yet';
  int _total = 0;

  String get message => _message;
  int get total => _total;
  Future<void> reload(int employeeId, String companyId) async {
    final totalResponse = await ApiService().fetchTotalNotification(employeeId, companyId); // Sử dụng ID và companyId thực tế
    _total = totalResponse.response!;
    notifyListeners();
  }

  Future<void> initialize(int employeeId, String companyId) async {
    await _signalRService.initialize(employeeId.toString());
    final totalResponse = await ApiService().fetchTotalNotification(employeeId, companyId); // Sử dụng ID và companyId thực tế
    _total = totalResponse.response!;
    notifyListeners();

    // _signalRService.onReceiveReplacementMessage((message) {
    //   _message = message?[0].toString() ?? 'No message';
    //   LocalNotificationService().showNotificationAndroid("Replace request", _message);
    //   notifyListeners();
    // });
    // _signalRService.onReceiveOvertimeMessage((message) {
    //   _message = message?[0].toString() ?? 'No message';
    //   LocalNotificationService().showNotificationAndroid("Overtime request", _message);
    //   notifyListeners();
    // });
    // _signalRService.onReceiveLeaveMessage((message) {
    //   _message = message?[0].toString() ?? 'No message';
    //   LocalNotificationService().showNotificationAndroid("Leave request", _message);
    //   notifyListeners();
    // });
    _signalRService.onReceiveTotalNotification((message) {
      _total = int.parse(message?[0].toString() ?? '0');
      notifyListeners();
    });
    _signalRService.onClose((error) {
      print('Connection closed');
    });
    _signalRService.onReconnected((connectionId) {
      print('Connection reestablished with ID: $connectionId');
    });
    _signalRService.onReconnecting((error) {
      print('Connection lost. Reconnecting');
    });
  }

  Future<void> sendMessage(String message) async {
    await _signalRService.sendMessage(message);
    print('Message sent');
  }
}