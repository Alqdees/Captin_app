import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification_of_support/route/HomeScreen.dart';
import 'package:provider/provider.dart';
import '../model_provider/provider.dart';
import 'SignInScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const ROUTE = '/SplashScreen';

  @override
  Widget build(BuildContext context) {
    final providModel = Provider.of<ModelProvider>(context, listen: false);
    providModel.getObj();
    Future.delayed(const Duration(seconds: 3), () {
      if (providModel.isLogged() ?? false) {
        providModel.removeScreen(context, HomeScreen.Route, false);
      } else {
        providModel.removeScreen(context, SignInScreen.Route, false);
      }
      SystemChrome.restoreSystemUIOverlays();
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
