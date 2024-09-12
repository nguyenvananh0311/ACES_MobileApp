import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Khởi tạo thông báo cho Android
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/launcher_icon');

    // Khởi tạo thông báo cho iOS
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  // Xử lý thông báo khi ứng dụng đang chạy trên iOS
  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    // Xử lý các hành động khi nhận được thông báo ở đây
  }

  Future<void> showNotificationAndroid(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('channel_id', 'CIM',
        channelDescription: 'Channel Description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }

  Future<void> showNotificationIos(String title, String body) async {
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
    DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'default',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics);
  }
}
