import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notification_of_support/route/HomeScreen.dart';
import 'package:notification_of_support/route/SignInScreen.dart';
import 'package:provider/provider.dart';

import '../model_provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providModel = Provider.of<ModelProvider>(context, listen: false);
    providModel.getObj();
    // print(providModel.isLogged());
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (providModel.isLogged() ?? false) {
        providModel.removeScreen(context, HomeScreen.Route, false);
        timer.cancel();
        return;
      } else {
        print(providModel.isLogged() ?? false);
        providModel.removeScreen(context, SignInScreen.Route, false);

        timer.cancel();
      }
    });

    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('SplashScreen'),
        TextButton(
          onPressed: () {},
          child: const Text('Click'),
        ),
      ],
    )));
  }
}
