import 'package:flutter/material.dart';
import 'package:notification_of_support/model_provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../generated/l10n.dart';

class SignInScreen extends StatelessWidget {
  static const Route = '/SignInScreen';
  final TextEditingController _otpController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ModelProvider>(context, listen: false);
    prov.getObj();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(1.h),
        child: Column(
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Waiting Plaese... '),
                    elevation: 8,
                    duration: Duration(seconds: 2),
                  ),
                );
                // context.read<ModelProvider>().sendSMS(_otpController.text);
                Future.delayed(const Duration(seconds: 4), () async {
                  prov.sendSMS(_otpController.text.toString(),context);
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 104, 181, 173),
                ),
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
