import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../generated/l10n.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Screen'),
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
              onChanged: (txt) {
                setState(() {
                  print(txt);
                });
              },
              decoration: InputDecoration(
                counterText: _otpController.text.length.toString(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {
                // Do something when the button is pressed
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.h),
                ),
                side: BorderSide(color: Colors.blue, width: 0.2.w),
              ),
              child: Text(
                S.of(context).confirm,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
