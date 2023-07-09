import 'package:notification_of_support/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});
  static const Route = "DetailScreen";

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).detail_screen),
        elevation: 12.sp,
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Text('Details '),
           SizedBox(height: 23.sp,)
           

          ],
        ),
      ),
    );
  }
}
