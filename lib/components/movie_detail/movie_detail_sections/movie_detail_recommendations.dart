import 'package:flutter/material.dart';

import '../../../components/common/vertical_movie_section.dart';
import '../../../dtos/movie_dto.dart';

class MovieDetailRecommendations extends StatelessWidget {
  final List<MovieDto> recommendedMovies;

  const MovieDetailRecommendations(
      {super.key, required this.recommendedMovies});

  @override
  Widget build(BuildContext context) {
    return VerticalMovieSection(
      movies: recommendedMovies,
    );
  }
}
