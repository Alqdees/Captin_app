import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notification_of_support/route/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart ' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sizer/sizer.dart';

import '../generated/l10n.dart';

class ModelProvider extends ChangeNotifier {
  List users = [];
  List search = [];
  Widget title = Text(S.current.absence_student);
  Icon actionsicon = const Icon(Icons.search);
  late SharedPreferences prefs;
  FirebaseMessaging? _firebaseMessaging;
  String? _token;
  bool? _isAvailable;
  bool? isRegister;
  bool? get isAvailable => _isAvailable;
  final TextEditingController number = TextEditingController();

  void getObj() async {
    prefs = await SharedPreferences.getInstance();
  }

  void changewidget() {
    if (actionsicon.icon == Icons.search) {
      actionsicon = const Icon(Icons.close);
      title = TextField(
        controller: number,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
        onSubmitted: (v) {
          searchName(v);
          print('____$v');
        },
      );
      notifyListeners();
    } else {
      getDataFromApi();
      number.text = "";
      actionsicon = const Icon(Icons.search);
      title = Text(S().absence_student);
      notifyListeners();
    }

  }

  void getOBJMesseging() async {
    prefs = await SharedPreferences.getInstance();
    _firebaseMessaging = FirebaseMessaging.instance;
    _token = await _firebaseMessaging?.getToken();
  }

  void managerScreen(String route, BuildContext context, Object? object) {
    Navigator.pushNamed(
      context,
      route,
      arguments: object,
    );
    notifyListeners();
  }

  void searchName(String? name) {
    if (name == null) return;

    for (var element in users) {
      if (element['student_name'].toString().contains(name)) {
        search.add(element);
      }
    }
    users = search;
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

  Future<void> removeData(BuildContext context) async {
    await prefs.remove('isLoggin');
    await prefs.clear();
    _isAvailable = false;
    isRegister = false;
    // ignore: use_build_context_synchronously
    removeScreen(context, SplashScreen.ROUTE, false);
    notifyListeners();
  }

  void getDataFromApi() async {
    final url = Uri.parse('https://pointiq.site/vendor/DataIndex3ToJson.php');
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Timer.periodic(
        const Duration(seconds: 6),
        (timer) {
          getDataFromApi();
          print('______${timer.tick}');
          timer.cancel();
          return;
        },
      );
    } else {
      Response response = await http.get(url);
      if (response.statusCode == 200) {
        users = json.decode(response.body);
      } else {
        print(response.statusCode);
      }
      notifyListeners();
    }
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
      getOBJMesseging();
      Map<String, dynamic> stat = jsonDecode(response.body);
      _isAvailable = stat['message'];
    }
    notifyListeners();
  }

  Future<void> registerInApi(String number) async {
    // print('___________Register in a number $_token');
    final url = Uri.parse(
      'https://pointiq.site/apiSendNoti/',
    );
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    final data = {
      'token': _token,
      'number': number,
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> stat = jsonDecode(response.body);
      isRegister = stat['message'];
    } else {
      print('________________ErrorReg: ${response.statusCode}');
    }
    notifyListeners();
  }
}
