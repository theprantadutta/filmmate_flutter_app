import 'package:flutter/material.dart';

class MovieReviews extends StatelessWidget {
  final String? imdbRating;
  final String? rottenTomatoesScore;
  final String? metaCriticScore;

  const MovieReviews({
    super.key,
    this.imdbRating,
    this.rottenTomatoesScore,
    this.metaCriticScore,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MovieReviewSection(
          imageUrl: 'assets/images/imdb_logo.png',
          score: imdbRating ?? 'N/A',
        ),
        MovieReviewSection(
          imageUrl: 'assets/images/rotten_tomatoes_logo.png',
          score: rottenTomatoesScore ?? 'N/A',
        ),
        MovieReviewSection(
          imageUrl: 'assets/images/metacritic_logo.png',
          score: metaCriticScore != null ? '$metaCriticScore%' : 'N/A',
        ),
      ],
    );
  }
}

class MovieReviewSection extends StatelessWidget {
  final String imageUrl;
  final String score;

  const MovieReviewSection({
    super.key,
    required this.score,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Image.asset(
            imageUrl,
            height: MediaQuery.sizeOf(context).height * 0.08,
            width: MediaQuery.sizeOf(context).width * 0.3,
            fit: BoxFit.contain,
          ),
          Text(score),
        ],
      ),
    );
  }
}
