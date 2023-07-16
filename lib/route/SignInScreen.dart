import 'package:flutter/material.dart';
import 'package:notification_of_support/model_provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../generated/l10n.dart';

class SignInScreen extends StatefulWidget {
  static const Route = '/SignInScreen';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _otpController = TextEditingController();

  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  String selectedItem = 'Item 1';
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ModelProvider>(context, listen: false);
    prov.getObj();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 6.h,
            ),
            Center(
              child: Text(
                S.of(context).selectClass,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Center(
              child: DropdownButton<String>(
                value: selectedItem,
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue!;
                  });
                },
              ),
            ),
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
                if (_otpController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).enterNumber),
                    ),
                  );
                  return;
                }
                if (_otpController.text.length < 11) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).ShortNumber),
                    ),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).wait),
                    elevation: 8,
                    duration: const Duration(seconds: 2),
                  ),
                );
                Future.delayed(
                  const Duration(seconds: 4),
                  () async {
                    // print('___________onClick');
                    prov.sendSMS(_otpController.text, context);
                  },
                );
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

  // void _showPopupMenu(BuildContext context, Offset offset) async {
  //   final RenderBox overlay =
  //       Overlay.of(context).context.findRenderObject() as RenderBox;
  //   final RelativeRect position = RelativeRect.fromRect(
  //     Rect.fromPoints(
  //       offset,
  //       offset.translate(0, 0),
  //     ),
  //     Offset.zero & overlay.size,
  //   );
  //   final selectedItem = await showMenu<String>(
  //     context: context,
  //     position: position,
  //     items: <PopupMenuEntry<String>>[
  //       const PopupMenuItem<String>(
  //         value: 'Option 1',
  //         child: Text('Option 1'),
  //       ),
  //       const PopupMenuItem<String>(
  //         value: 'Option 2',
  //         child: Text('Option 2'),
  //       ),
  //       const PopupMenuItem<String>(
  //         value: 'Option 3',
  //         child: Text('Option 3'),
  //       ),
  //     ],
  //   );
  // }
}
