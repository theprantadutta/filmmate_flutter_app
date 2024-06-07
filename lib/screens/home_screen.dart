import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../components/layouts/main_layout.dart';
import '../../constants/colors.dart';
import '../../services/database_service.dart';
import '../components/home/genres_section.dart';
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
                      child: Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: kPrimaryColor,
                          size: 50,
                        ),
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
                  final discoverMovies = snapshot.data!.discoverMovies;
                  final nowPlayingMovies = snapshot.data!.nowPlayings;
                  final popularMovies = snapshot.data!.popularMovies;
                  final topRatedMovies = snapshot.data!.topRatedMovies;
                  final upcomingMovies = snapshot.data!.upcomingMovies;
                  final genres = snapshot.data!.genres;
                  genres.sort((a, b) => a.name.compareTo(b.name));
                  return Column(
                    children: [
                      GenresSection(
                        genres: genres,
                      ),
                      const SizedBox(height: 10),
                      MovieSection(
                        title: 'Discover Movies',
                        movies: discoverMovies,
                      ),
                      const SizedBox(height: 10),
                      MovieSection(
                        title: 'Popular Movies',
                        movies: popularMovies,
                      ),
                      const SizedBox(height: 10),
                      MovieSection(
                        title: 'Now Playing Movies',
                        movies: nowPlayingMovies,
                      ),
                      const SizedBox(height: 10),
                      MovieSection(
                        title: 'Top Rated Movies',
                        movies: topRatedMovies,
                      ),
                      const SizedBox(height: 10),
                      MovieSection(
                        title: 'Upcoming Movies',
                        movies: upcomingMovies,
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
