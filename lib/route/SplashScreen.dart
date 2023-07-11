import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification_of_support/constants/assets_images.dart';
import 'package:notification_of_support/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../model_provider/provider.dart';
import 'HomeScreen.dart';
import 'SignInScreen.dart';
// import 'package:flutter/services.dart';
// import 'package:notification_of_support/route/HomeScreen.dart';
// import 'package:provider/provider.dart';
// import '../model_provider/provider.dart';
// import 'SignInScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const ROUTE = '/SplashScreen';

  @override
  Widget build(BuildContext context) {
    final providModel = Provider.of<ModelProvider>(context, listen: false);
    providModel.getObj();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (providModel.isLogged() ?? false) {
          providModel.removeScreen(context, HomeScreen.Route, false);
        } else {
          providModel.removeScreen(context, SignInScreen.Route, false);
        }
        SystemChrome.restoreSystemUIOverlays();
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).welcome,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Image.asset(
              Assets.imagesLogo,
              width: 150,
              height: 150,
            ),
            SizedBox(height: 2.h),
            Text(
              S.of(context).nameApp,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 2.h),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
