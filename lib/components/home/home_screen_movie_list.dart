import 'package:flutter/material.dart';

import '../../enums/movie_type.dart';
import '../../models/home_screen_response.dart';
import 'genres_section.dart';
import 'movie_section.dart';
import 'movie_section/movie_section_top_bar.dart';

class HomeScreenMovieList extends StatelessWidget {
  final HomeScreenResponse data;

  const HomeScreenMovieList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final discoverMovies = data.discoverMovies;
    final nowPlayingMovies = data.nowPlayings;
    final popularMovies = data.popularMovies;
    final topRatedMovies = data.topRatedMovies;
    final upcomingMovies = data.upcomingMovies;
    final genres = data.genres;

    return SingleChildScrollView(
      child: Column(
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
            movies: discoverMovies.movies,
            movieType: MovieType.discover,
          ),
          const SizedBox(height: 10),
          MovieSection(
            title: 'Popular Movies',
            movies: popularMovies.movies,
            movieType: MovieType.popular,
          ),
          const SizedBox(height: 10),
          MovieSection(
            title: 'Now Playing Movies',
            movies: nowPlayingMovies.movies,
            movieType: MovieType.nowPlaying,
          ),
          const SizedBox(height: 10),
          MovieSection(
            title: 'Upcoming Movies',
            movies: upcomingMovies.movies,
            movieType: MovieType.upcoming,
          ),
          const SizedBox(height: 10),
          MovieSection(
            title: 'Top Rated Movies',
            movies: topRatedMovies.movies,
            movieType: MovieType.topRated,
          ),
        ],
      ),
    );
  }
}

class HomeScreenMovieListSkeletor extends StatelessWidget {
  const HomeScreenMovieListSkeletor({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          MovieSectionTopBarSkeletor(),
          GenresSectionSkeletor(),
          SizedBox(height: 10),
          MovieSectionSkeletor(),
          SizedBox(height: 10),
          MovieSectionSkeletor(),
          SizedBox(height: 10),
          MovieSectionSkeletor(),
          SizedBox(height: 10),
          MovieSectionSkeletor(),
          SizedBox(height: 10),
          MovieSectionSkeletor(),
        ],
      ),
    );
  }
}
