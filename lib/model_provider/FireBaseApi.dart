import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_of_support/main.dart';

import '../route/Detail_screen.dart';

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  print('Received background message: ${message.data}');
  // print(message.notification?.title);
  // print(message.notification?.body);

  // Perform custom logic here, such as updating local data or displaying a notification
}

void handeMessage(RemoteMessage? message) {
  if (message == null) return;
  navigatorKey.currentState?.pushNamed(DetailScreen.Route, arguments: message);
}

Future initPush() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  FirebaseMessaging.instance.getInitialMessage().then(handeMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(handeMessage);
  FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
}

class FireBaseApi {
  final _fireMessaging = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    await _fireMessaging.requestPermission();
    // final fcmToken = await _fireMessaging.getToken();
    initPush();
  }
}
