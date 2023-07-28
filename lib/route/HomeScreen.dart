import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_of_support/model_provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../generated/l10n.dart';
import 'Widget/CardView.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const Route = '/HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void showNotification() async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
            "notifications-youtube", "YouTube Notifications",
            priority: Priority.max, importance: Importance.max);

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await Future.delayed(
      const Duration(seconds: 5),
      (() {
        notificationsPlugin.show(11, 'title', 'body', notiDetails,
            payload: 'notification Ahmed');
      }),
    );
  }

  void checkForNotification() async {
    NotificationAppLaunchDetails? details =
        await notificationsPlugin.getNotificationAppLaunchDetails();

    if (details != null) {
      if (details.didNotificationLaunchApp) {
        NotificationResponse? response = details.notificationResponse;

        if (response != null) {
          String? payload = response.payload;
          log("Notification Payload___________: $payload");
          print("Notification Payload___________: $payload");
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkForNotification();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        // String? title = message.notification!.title;
        // String? body = message.notification!.body;

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(message.notification!.title.toString()),
                content: Text(
                  message.notification!.body.toString(),
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(S.of(context).cancel),
                  )
                ],
              );
            });
      },
    );
  }

  // final TextEditingController _number = TextEditingController();
  int i = 0;
  @override
  Widget build(BuildContext context) {
    context.read<ModelProvider>().getDataFromApi();
    return Consumer<ModelProvider>(
      builder: (context, value, child) {
        i++;
        log('-----$i');
        return Scaffold(
          appBar: AppBar(
            title: value.title,
            elevation: 12.0,
            actions: [
              IconButton(
                onPressed: () {
                  context.read<ModelProvider>().changewidget();
                },
                icon: value.actionsicon,
              ),
            ],
          ),
          body: value.users.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(S.of(context).wait)
                    ],
                  ),
                )
              : Center(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: value.users.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8,
                          shadowColor: Colors.black,
                          child: CardView(
                            name: value.users[index]['student_name'],
                            msgContent: value.users[index]['absence_date'],
                          ),
                        );
                      },
                    ),
                  ),
                ),
        );
      },
    );
  }
}
