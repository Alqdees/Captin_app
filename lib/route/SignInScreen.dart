import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notification_of_support/model_provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../generated/l10n.dart';

class SignInScreen extends StatelessWidget {
  static const Route = '/SignInScreen';
  final TextEditingController _otpController = TextEditingController();

  FirebaseAuth? auth;
  SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    auth = FirebaseAuth.instance;
    auth?.setLanguageCode('en-US');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(1.h),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Center(
              child: Text(
                S.of(context).getNumber,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.teal),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.teal),
                ),
              ),
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: () async {
                // Center(child: CircularProgressIndicator(
                //   strokeWidth: 4,
                // ));
                // if (_otpController.text.isEmpty) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text(
                //         S.of(context).enterNumber,
                //       ),
                //     ),
                //   );
                //   return;
                // }
                // if (_otpController.text.length < 11) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text(S.of(context).ShortNumber)));
                //   return;
                // }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Waiting Plaese... '),
                    elevation: 8,
                    duration: Duration(seconds: 2),
                  ),
                );
                // context.read<ModelProvider>().sendSMS(_otpController.text);
                Future.delayed(const Duration(seconds: 4), () async {
                  await auth?.verifyPhoneNumber(
                    phoneNumber: '+964${_otpController.text.substring(1)}',
                    verificationCompleted: (PhoneAuthCredential credential) {
                      print("____1____${credential.smsCode}");
                    },
                    verificationFailed: (FirebaseAuthException e) {
                      print("____${e.message}");
                    },
                    codeSent: (String verificationId, int? resendToken) {
                      print("verificationId_________${verificationId}");
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {
                      print("____${verificationId}");
                    },
                  );
                });
              },
              child: Text(
                S.of(context).Sign,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  backgroundColor: Colors.transparent,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 104, 181, 173)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
