import 'package:flutter/material.dart';

import '../../components/layouts/main_layout.dart';
import '../components/home/home_header.dart';
import '../components/home/home_trending_section.dart';

class HomeScreen extends StatelessWidget {
  static const kRouteName = '/';

  // final User? _user = AuthService().currentUser;

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              HomeHeader(),
              HomeTrendingSection(),
            ],
          ),
        ),
      ),
    );
  }
}
