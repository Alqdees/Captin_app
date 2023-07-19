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
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
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

  @override
  Widget build(BuildContext context) {
    context.read<ModelProvider>().getContactData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("RealTime"),
        elevation: 12.0,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       context.read<ModelProvider>().removeData(context);
        //     },
        //     icon: const Icon(Icons.logout),
        //   ),
        // ],
      ),
      body: Consumer<ModelProvider>(
        builder: (context, value, c) {
          return value.users.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
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
                            name: value.users[index]['name'],
                            msgContent: value.users[index]['msgContent'],
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
