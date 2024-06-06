import 'package:filmmate_flutter_app/components/movie_detail/movie_detail_sections/movie_detail_recommendation_section.dart';
import 'package:flutter/material.dart';

import '../../../entities/movie.dart';

class MovieDetailRecommendations extends StatelessWidget {
  final List<Movie> recommendedMovies;

  const MovieDetailRecommendations(
      {super.key, required this.recommendedMovies});

  @override
  Widget build(BuildContext context) {
    return MovieDetailRecommendationSection(
      recommendedMovies: recommendedMovies,
    );
  }
}
