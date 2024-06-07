import 'package:flutter/material.dart';

import '../../../components/common/vertical_movie_section.dart';
import '../../../entities/movie.dart';

class MovieDetailRecommendations extends StatelessWidget {
  final List<Movie> recommendedMovies;

  const MovieDetailRecommendations(
      {super.key, required this.recommendedMovies});

  @override
  Widget build(BuildContext context) {
    return VerticalMovieSection(
      movies: recommendedMovies,
    );
  }
}
