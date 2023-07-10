import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class SendNotification {

static sendNotification(String deviceToken, String title, String body) async {
    const serverKey = 'AAAAy8LDVew:APA91bFDqumw5mbUu4rmiHMieTOK54XuhCw-0b5ApYLhpjiHjfME12DPxVqXKbx0icyB5y4jc6PFojADKndGE96yFgMltL5ZEJNqTQRxRLFtV2NgAc45BvGPKAI6fH65mEDUakG82LBN';

    const fcmEndpoint = 'https://fcm.googleapis.com/fcm/send';

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final data = <String, dynamic>{
      'notification': <String, dynamic>{
        'title': title,
        'body': body,
      },
      'to': deviceToken,
    };

    final response = await http.post(Uri.parse(fcmEndpoint),
        headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      print('_______Notification sent successfully.');
    } else {
      print('________Notification sending failed.');
    }
  }



    }
