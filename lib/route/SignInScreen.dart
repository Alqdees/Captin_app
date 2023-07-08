import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification_of_support/model_provider/provider.dart';
import 'package:notification_of_support/route/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  static const Route = '/SignInScreen';
  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<ModelProvider>(context, listen: false);
    userModel.getObj();
    userModel.saveData();
    if (userModel.isLoggedIn) {
      return const HomeScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  final userModel =
                      Provider.of<ModelProvider>(context, listen: false);
                  userModel.signIn(_usernameController.text,
                      _passwordController.text, context);
                  // context
                  //     .read<ModelProvider>()
                  //     .managerScreen(HomeScreen.Route, context);
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
