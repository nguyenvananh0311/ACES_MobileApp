import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:signalr_core/signalr_core.dart';
import 'dart:async';

class SignalRService {
  late HubConnection _hubConnection;
  final String _serverUrl =
      "${dotenv.env['API_URL'] ?? 'https://203.176.128.5:5678'}/notificationHub?employeeId=";
  bool _isConnected = false;
  Timer? _reconnectTimer;
  final int _retryDelay = 20; // Retry every 5 seconds

  Future<void> initialize(String employeeId) async {
    _hubConnection =
        HubConnectionBuilder().withUrl(_serverUrl + employeeId).build();
    await _startConnection();
  }

  Future<void> _startConnection() async {
    try {
      await _hubConnection.start();
      _isConnected = true;
      print('Connection started');
    } catch (error) {
      _isConnected = false;
      print('Failed to start connection: $error');
      _startReconnectTimer();
    }
  }

  void _startReconnectTimer() {
    if (_reconnectTimer == null || !_reconnectTimer!.isActive) {
      _reconnectTimer =
          Timer.periodic(Duration(seconds: _retryDelay), (timer) async {
        if (!_isConnected) {
          print('Attempting to reconnect...');
          await _startConnection();
        } else {
          _reconnectTimer?.cancel();
        }
      });
    }
  }

  void onReceiveTotalNotification(
      void Function(List<dynamic>? message) callback) {
    _hubConnection.on('TotalNotification', callback);
  }

  Future<void> sendMessage(String message) async {
    if (_isConnected) {
      await _hubConnection.invoke('SendMessage', args: <Object>[message]);
      print('Message sent');
    } else {
      print('Connection not established. Message not sent.');
    }
  }

  void onClose(void Function(Exception? error) callback) {
    _hubConnection.onclose((error) {
      _isConnected = false;
      print('Connection closed. Starting reconnection...');
      _startReconnectTimer();
      callback(error);
    });
  }

  void onReconnected(Function(String? connectionId) callback) {
    _hubConnection.onreconnected((connectionId) {
      _isConnected = true;
      print('Connection reestablished with ID: $connectionId');
      callback(connectionId);
    });
  }

  void onReconnecting(void Function(Exception? error) callback) {
    _hubConnection.onreconnecting((error) {
      _isConnected = false;
      print('Connection lost. Reconnecting...');
      callback(error);
    });
  }

  Future<void> stop() async {
    await _hubConnection.stop();
    _isConnected = false;
    _reconnectTimer?.cancel();
  }
}
