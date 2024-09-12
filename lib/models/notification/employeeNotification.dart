import 'notification.dart';

class EmployeeNotification {
  final int employeeId; // Using String for Guid
  final String notificationId;
  bool isRead;
  final Notification notification;

  bool get getIsRead{
    return isRead;
  }

  set setIsRead(bool value) {
    isRead = value;
  }
  EmployeeNotification({
    required this.employeeId,
    required this.notificationId,
    required this.isRead,
    required this.notification,
  });


  factory EmployeeNotification.fromJson(Map<String, dynamic> json) {
    return EmployeeNotification(
        employeeId: json['employeeId'],
        notificationId: json['notificationId'],
        isRead: json['isRead'],
        notification: Notification.fromJson(json['notification']),

    );
  }
  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'notificationId': notificationId,
      'isRead': isRead,
      'notification': notification.toJson(),
    };
  }
}