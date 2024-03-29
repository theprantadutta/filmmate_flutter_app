import 'package:flutter/material.dart';

import '../../components/layouts/main_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
