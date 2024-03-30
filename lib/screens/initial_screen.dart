import 'package:filmmate_flutter_app/screens/home_screen.dart';
import 'package:filmmate_flutter_app/screens/login_screen.dart';
import 'package:filmmate_flutter_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  static const kRouteName = '/';
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        }
        return const LoginScreen();
      },
    );
  }
}
