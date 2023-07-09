import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:notification_of_support/route/HomeScreen.dart';
import 'package:notification_of_support/route/OtpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/SendDataOtp.dart';

class ModelProvider extends ChangeNotifier {
  List users = [];
  late ConnectivityResult result;
  // List get usList => users;
  late FirebaseDatabase database;
  late DatabaseReference databaseReference;
  late SharedPreferences prefs;

  FirebaseAuth? auth;
  void getObj() async {
    prefs = await SharedPreferences.getInstance();
    auth = FirebaseAuth.instance;
    auth?.setLanguageCode('en-US');
  }

  // List get us => users;

  Future getContactData() async {
    bool result = await _connection().then((value) => value);

    if (result) {
      databaseReference = await FirebaseDatabase.instance.ref('contactForm');
      users.clear();
      await databaseReference.onValue.listen(
        (event) {
          for (var child in event.snapshot.children) {
            users.add(child.value);
          }
        },
      );
      Timer.periodic(const Duration(seconds: 1), (timer) {
        // Call your function here
        if (users.isEmpty) {
          // notifyListeners();
          // print('is empty');
          return;
        }
        // print('is not empty');
        notifyListeners();
        timer.cancel();
        return;
      });
      return;
    }
    Timer.periodic(const Duration(seconds: 20), (timer) {
      // Call your function here
      print('is empty 20  seconds');
      if (users.isEmpty) {
        // notifyListeners();
        getContactData();
        // print('is empty');
        timer.cancel();
        return;
      }
      // print('is not empty');

      notifyListeners();
      timer.cancel();
      return;
    });
  }

  Future<bool> _connection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;
  }

  void managerScreen(String route, BuildContext context, Object? object) {
    Navigator.pushNamed(context, route, arguments: object);
    notifyListeners();
  }

  void removeScreen(BuildContext context, String route, bool pro) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
      (route) {
        return pro;
      },
    );
    notifyListeners();
  }

  bool? isLogged() {
    return prefs.getBool('isLoggin');
  }

  Future<void> saveData() async {
    prefs.setBool('isLoggin', true);
  }

  void sendSMS(String number, BuildContext context) async {
    // await auth?.signInWithPhoneNumber('+964${number.substring(1)}');

    await auth?.verifyPhoneNumber(
      phoneNumber: '+964${number.substring(1)}',
      verificationCompleted: (PhoneAuthCredential credential) {
        print("verificationCompleted____${credential.smsCode}");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("verificationFailed____${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        managerScreen(OtpScreen.ROUTE, context, DataToOTP(verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("codeAutoRetrievalTimeout________${verificationId}");
      },
    );
    notifyListeners();
  }

  void signInWithOTP(
      String verificationId, String smsCode, BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    UserCredential? result = await auth?.signInWithCredential(credential);
    User? user = result?.user;
    if (user != null) {
      removeScreen(context, HomeScreen.Route, false);
      saveData();
      // User signed in
    } else {
      print('___________Sign in failed');
      // Sign in failed
    }
    notifyListeners();
  }
}
