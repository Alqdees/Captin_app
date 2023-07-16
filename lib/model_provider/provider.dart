import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification_of_support/Models/SendNotification.dart';
import 'package:notification_of_support/route/HomeScreen.dart';
import 'package:notification_of_support/route/OtpScreen.dart';
import 'package:notification_of_support/route/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart ' as http;
import '../Models/SendDataOtp.dart';

class ModelProvider extends ChangeNotifier {
  List users = [];
  late ConnectivityResult result;
  // List get usList => users;
  late FirebaseDatabase database;
  late DatabaseReference databaseReference;
  late SharedPreferences prefs;
  FirebaseMessaging? _firebaseMessaging;
  FirebaseAuth? auth;
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  String _selectedItem = 'Item 1';
  String? _token;
  bool? _isAvailable;
  String get select => _selectedItem;
  bool? get isAvailable => _isAvailable;


  // getState(bool state) {
  //   _isAvailable = state;
  //   notifyListeners();
  // }

  void getObj() async {
    auth = FirebaseAuth.instance;
    auth?.setLanguageCode('en-US');
  }

  void getOBJMesseging() async {
    prefs = await SharedPreferences.getInstance();
    _firebaseMessaging = FirebaseMessaging.instance;
    _token = await _firebaseMessaging?.getToken();
  }

  // List get us => users;

  Future getContactData() async {
    bool result = await connection().then((value) => value);

    if (result) {
      databaseReference = FirebaseDatabase.instance.ref('contactForm');
      users.clear();
      databaseReference.onValue.listen(
        (event) {
          for (var child in event.snapshot.children) {
            users.add(child.value);
          }
        },
      );
      Timer.periodic(const Duration(seconds: 1), (timer) {
        // Call your function here
        if (users.isEmpty) {
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

  Future<bool> connection() async {
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
        managerScreen(OtpScreen.ROUTE, context,
            DataToOTP(verificationId: verificationId, number: number));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("codeAutoRetrievalTimeout________$verificationId");
      },
    );
    notifyListeners();
  }

  void signInWithOTP(String verificationId, String number, String smsCode,
      BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    UserCredential? result = await auth?.signInWithCredential(credential);

    User? user = result?.user;
    if (user != null) {
      removeScreen(context, HomeScreen.Route, false);
      saveData();

      // User signed in
    } else {
      removeScreen(context, SplashScreen.ROUTE, false);
      return;
      // Sign in failed
    }
    notifyListeners();
  }

  void sendNotification() async {
    SendNotification.sendNotification(
      'dsdnGviKTtW3nx_Eg9pDbY:APA91bEYILyGOKhjWdPZf0SMXW7Je59hGw9EBIR4elftLssG8eKinO8Pe9LEOJN6txye_kNV5lXHchGWZZS3UOb4maldN9kXblZFSPMXL7eRwgK76bk0x5gAedvajGfHbmke_ShRc8QZ',
      'مساء الخير',
      'اذا اشتغل راسلني ',
    );
    notifyListeners();
  }

  Future<void> sendData(String number) async {
    final url = Uri.parse(
      'https://pointiq.site/tolkingWIthAndr/',
    );
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    final data = {'phone': number};

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> stat = jsonDecode(response.body);
      // ignore: unrelated_type_equality_checks
      getOBJMesseging();
      _isAvailable = stat['message'] == 'true';

    } else {
      // Error: handle the error
      print('___________Request failed with status: ${response.statusCode}');
    }

    notifyListeners();
  }

  void getStringData(String data) {
    _selectedItem = data;
    notifyListeners();
  }

  Future<void> registerInApi(String number) async {
    // print('___________Register in a number $_token');
  }
}
