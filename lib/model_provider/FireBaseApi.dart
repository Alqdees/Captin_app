import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification_of_support/main.dart';
import '../route/Detail_screen.dart';

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  print('Received background message: ${message.data}');
  print(message.notification?.title);
  print(message.notification?.body);

  // Perform custom logic here, such as updating local data or displaying a notification
}

void handeMessage(RemoteMessage? message) {
  if (message == null) return;
  navigatorKey.currentState?.pushNamed(DetailScreen.Route, arguments: message);
}

Widget? showDailogNotification(RemoteMessage? message) {
  return const OpenDailog();
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
    await _fireMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    // print('______ ${await _fireMessaging.getToken()}');
    // await _fireMessaging.getToken();

    initPush();
  }
}

class OpenDailog extends StatelessWidget {
  const OpenDailog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('data'),
      content: Text('contean'),
    );
  }
}
