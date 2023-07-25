
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        String? title = message.notification!.title;
        String? body = message.notification!.body;

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
        // AwesomeNotifications().createNotification(
        //     content: NotificationContent(
        //       id: 123,
        //       channelKey: 'call_channel',
        //       color: Colors.white,
        //       title: title,
        //       body: body,
        //       category: NotificationCategory.Event,
        //       wakeUpScreen: true,
        //       fullScreenIntent: true,
        //       autoDismissible: true,
        //       backgroundColor: Colors.yellowAccent,
        //     ),
        //     actionButtons: [
        //       NotificationActionButton(
        //         key: 'Cancel',
        //         label: 'Cancel',
        //         autoDismissible: true,
        //       ),
        //     ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<ModelProvider>().getDataFromApi();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).absence_student),
        elevation: 12.0,
        actions: [
          IconButton(
            onPressed: () async {
              context.read<ModelProvider>().removeData(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Consumer<ModelProvider>(
        builder: (context, value, c) {
          return value.users.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
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
                );
        },
      ),
    );
  }
}
