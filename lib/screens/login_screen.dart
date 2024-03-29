import 'package:filmmate_flutter_app/components/common/custom_text_input.dart';
import 'package:filmmate_flutter_app/constants/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const kRouteName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            CustomTextInput(
              labelText: 'Enter your email',
            ),
            CustomTextInput(
              labelText: 'Enter your Password',
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
                fixedSize: Size(MediaQuery.of(context).size.width * 0.95, 50),
              ),
              child: const Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
