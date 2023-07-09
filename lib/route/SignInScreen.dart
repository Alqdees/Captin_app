import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignInScreen extends StatelessWidget {
  static const Route = '/SignInScreen';
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             const TextField(
                
                decoration:  InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 16.0),
             const TextField(
                
                obscureText: true,
                decoration:  InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                style: const ButtonStyle(),
                onPressed: () {
               
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
