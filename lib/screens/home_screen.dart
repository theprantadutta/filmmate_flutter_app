import 'package:filmmate_flutter_app/enums/movie_type.dart';
import 'package:flutter/material.dart';

import '../../components/common/future_handler.dart';
import '../../components/layouts/main_layout.dart';
import '../../services/database_service.dart';
import '../components/home/genres_section.dart';
import '../components/home/home_header.dart';
import '../components/home/movie_section.dart';
import '../components/home/movie_section/movie_section_top_bar.dart';

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
              FutureHandler(
                defaultHeight: MediaQuery.sizeOf(context).height * 0.8,
                future: DatabaseService().getAllHomeScreenData(),
                builder: (context, snapshot) {
                  final discoverMovies = snapshot.data!.discoverMovies;
                  final nowPlayingMovies = snapshot.data!.nowPlayings;
                  final popularMovies = snapshot.data!.popularMovies;
                  final topRatedMovies = snapshot.data!.topRatedMovies;
                  final upcomingMovies = snapshot.data!.upcomingMovies;
                  final genres = snapshot.data!.genres;

                  return Column(
                    children: [
                      const MovieSectionTopBar(
                        title: 'Genres',
                        movieType: MovieType.genreWise,
                      ),
                      GenresSection(
                        genres: genres,
                      ),
                      const SizedBox(height: 10),
                      MovieSection(
                        title: 'Discover Movies',
                        movies: discoverMovies,
                        movieType: MovieType.discover,
                      ),
                      const SizedBox(height: 10),
                      MovieSection(
                        title: 'Popular Movies',
                        movies: popularMovies,
                        movieType: MovieType.popular,
                      ),
                      const SizedBox(height: 10),
                      MovieSection(
                        title: 'Now Playing Movies',
                        movies: nowPlayingMovies,
                        movieType: MovieType.nowPlaying,
                      ),
                      const SizedBox(height: 10),
                      MovieSection(
                        title: 'Top Rated Movies',
                        movies: topRatedMovies,
                        movieType: MovieType.topRated,
                      ),
                      const SizedBox(height: 10),
                      MovieSection(
                        title: 'Upcoming Movies',
                        movies: upcomingMovies,
                        movieType: MovieType.upcoming,
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
