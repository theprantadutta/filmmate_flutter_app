import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/layouts/main_layout.dart';

class HomeScreen extends StatefulWidget {
  static const kRouteName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // print('User is currently signed out!');
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
