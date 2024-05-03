import 'package:filmmate_flutter_app/services/movie_service.dart';
import 'package:flutter/material.dart';

import '../../components/layouts/main_layout.dart';
import '../components/home/home_header.dart';
import '../components/home/home_trending_section.dart';

class HomeScreen extends StatefulWidget {
  static const kRouteName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    MovieService.getDiscoverMovies();
    super.initState();
  }

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
