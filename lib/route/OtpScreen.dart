import 'package:flutter/material.dart';
import 'package:notification_of_support/Models/SendDataOtp.dart';
import 'package:notification_of_support/model_provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../generated/l10n.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);

  static const ROUTE = "/OtpScreen";

  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final myObject = ModalRoute.of(context)!.settings.arguments as DataToOTP;
    context.read<ModelProvider>().getOBJMesseging();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('OTP Screen')),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40.0),
            Text(
              S.of(context).descriptionOTP,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.h),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
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
            SizedBox(
              height: 6.h,
            ),
            ElevatedButton(
              onPressed: () {
                if (_otpController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Center(
                        child: Text(
                          S.of(context).EnterOTP,
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                  return;
                }
                if (_otpController.text.length < 6 ||
                    _otpController.text.length > 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Center(
                        child: Text(
                          S.of(context).ErrorOTP,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      S.of(context).wait,
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    duration: const Duration(seconds: 3),
                  ),
                );
                Future.delayed(
                  const Duration(seconds: 4),
                  () async {
                    context.read<ModelProvider>().signInWithOTP(
                        myObject.verificationId.toString(),
                        myObject.number.toString(),
                        _otpController.text,
                        context);
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 104, 181, 173)),
              ),
              child: Text(
                S.of(context).Sign,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
