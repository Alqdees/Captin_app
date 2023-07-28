import 'package:flutter/material.dart';
import 'package:notification_of_support/model_provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../generated/l10n.dart';
import 'HomeScreen.dart';

class SignInScreen extends StatelessWidget {
  static const Route = '/SignInScreen';

  SignInScreen({super.key});

  final TextEditingController _number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ModelProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(S.of(context).Sign),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 6.h,
              ),
              SizedBox(
                height: 2.h,
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
                controller: _number,
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
                  await checkAndRegister(context, prov);
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
      ),
    );
  }

  Future<void> myFunction(BuildContext context) async {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierColor: Colors.black26,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
  }

  Future<void> checkAndRegister(
    BuildContext context,
    ModelProvider provider,
  ) async {
    if (_number.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).enterNumber),
        ),
      );

      return;
    }
    if (_number.text.length < 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).ShortNumber),
        ),
      );

      return;
    }
    provider.sendData(_number.text);
    myFunction(context);
    await Future.delayed(
      const Duration(seconds: 3),
      () async {
        if (provider.isAvailable ?? false) {
          //
          await provider.registerInApi(_number.text);
          //
        }
        if (provider.isRegister ?? false) {
          await provider.saveData();
          provider.removeScreen(context, HomeScreen.Route, false);
          return;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 3),
              content: Text('Error'),
            ),
          );
        }
      },
    );
  }
}
