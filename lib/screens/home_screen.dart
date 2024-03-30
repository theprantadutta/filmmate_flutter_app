import 'package:filmmate_flutter_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/layouts/main_layout.dart';

class HomeScreen extends StatelessWidget {
  static const kRouteName = '/home';

  final User? _user = AuthService().currentUser;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Column(
        children: [
          Center(
            child: Text('UserEmail: ${_user?.email}'),
          ),
          ElevatedButton(
            onPressed: () async => AuthService().signOut(),
            child: const Text(
              'SignOut',
            ),
          ),
        ],
      ),
    );
  }
}

//  @override
//   void initState() {
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       if (user == null) {
//         // print('User is currently signed out!');
//         Navigator.pushReplacementNamed(context, LoginScreen.kRouteName);
//       } else {
//         print('User is signed in!');
//       }
//     });
//     super.initState();
//   }