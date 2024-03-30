import 'package:filmmate_flutter_app/constants/colors.dart';
import 'package:filmmate_flutter_app/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/common/custom_text_input.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  static const kRouteName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  Future<void> login() async {
    debugPrint("email: $email , pass: $password");
    try {
      final credential = await AuthService().signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint(credential.toString());

      // Navigator.pushReplacementNamed(
      //   // ignore: use_build_context_synchronously
      //   context,
      //   HomeScreen.kRouteName,
      // );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      debugPrint('Login Function Finished');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
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
              onChanged: (value) => email = value,
            ),
            CustomTextInput(
              labelText: 'Enter your Password',
              onChanged: (value) => password = value,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: login,
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
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                SignupScreen.kRouteName,
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: kPrimaryColor,
                fixedSize: Size(MediaQuery.of(context).size.width * 0.95, 50),
              ),
              child: const Text(
                'Signup Instead?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
