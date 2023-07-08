import 'package:flutter/material.dart';
import 'package:notification_of_support/model_provider/provider.dart';
import 'package:provider/provider.dart';
import 'SignInScreen.dart';
import 'Widget/CardView.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String Route = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    // final userModel = Provider.of<ModelProvider>(context);

    // if (!userModel.isLoggedIn) {
    //   return SignInScreen();
    // }
    context.read<ModelProvider>().getContactData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("RealTime"),
        elevation: 12.0,
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
                          shadowColor: Colors.tealAccent,
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
