import 'package:filmmate_flutter_app/components/home/categories_section.dart';
import 'package:filmmate_flutter_app/services/database_service.dart';
import 'package:flutter/material.dart';

import '../../components/layouts/main_layout.dart';
import '../components/home/home_header.dart';
import '../components/home/movie_section.dart';

class HomeScreen extends StatelessWidget {
  static const kRouteName = '/';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const HomeHeader(),
              FutureBuilder(
                future: DatabaseService().getAllHomeScreenData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: Text('Something Went Wrong'),
                      ),
                    );
                  }
                  final discoverMovies =
                      snapshot.data!.discoverMovieResponse.movies;
                  final genres = snapshot.data!.genres;
                  return Column(
                    children: [
                      CategoriesSection(
                        genres: genres,
                      ),
                      const SizedBox(height: 10),
                      MovieSection(
                        title: 'Discover Movies',
                        movies: discoverMovies,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
