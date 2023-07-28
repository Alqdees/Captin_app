import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ServiceNotification {
  static FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeNotification() async {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onBackgroundMessage(showNotification);
    //   AndroidNotificationDetails androidDetails =
    //       const AndroidNotificationDetails(
    //           "notifications-youtube", "YouTube Notifications",
    //           priority: Priority.max, importance: Importance.max);

    //   DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
    //     presentAlert: true,
    //     presentBadge: true,
    //     presentSound: true,
    //   );

    //   NotificationDetails notiDetails =
    //       NotificationDetails(android: androidDetails, iOS: iosDetails);
    // notificationsPlugin.show(11, 'title', 'body', notiDetails,
    //           payload: 'notification Ahmed');

    // ,);
    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    DarwinInitializationSettings iosSettings =
        const DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestCriticalPermission: true,
            requestSoundPermission: true);

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    bool? initialized = await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        log(response.payload.toString());
      },
    );

    log("Notifications:  $initialized");
  }

  static Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      message.notification!.title!,
      message.notification!.body!,
      priority: Priority.max,
      importance: Importance.max,
    );

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
        notificationsPlugin.show(11, 'title', 'body', notiDetails,
            payload: 'action');

  }
}
