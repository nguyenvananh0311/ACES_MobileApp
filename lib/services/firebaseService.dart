import 'package:firebase_messaging/firebase_messaging.dart';

import '../models/notification/subscription.dart';
import 'apiService.dart';
import 'notification/localNotificationService.dart';

class FirebaseService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void initializeFirebaseMessaging(int employeeId, String companyId) {
    _firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService().showNotificationAndroid(
        '${message.notification?.title}', '${message.notification?.body}');
    });

    _firebaseMessaging.getToken().then((token) {
      if (token != null) {
        Subscription subscription = Subscription(id: employeeId, token: token);
        ApiService().subscribe(subscription, companyId);
      }
    });
  }
}
