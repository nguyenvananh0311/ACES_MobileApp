import 'package:permission_handler/permission_handler.dart';

class RequestPermission{
  Future<void> requestNotificationPermission() async {
    var status = await Permission.notification.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      // Yêu cầu quyền nếu chưa được cấp
      await Permission.notification.request();
    }
  }
}