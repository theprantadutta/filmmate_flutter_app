import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../entities/movie.dart';
import 'movie_poster/movie_average_vote.dart';
import 'movie_poster/movie_poster.dart';
import 'movie_poster/movie_poster_genres.dart';
import 'movie_poster/poster_back_button.dart';
import 'movie_poster/poster_middle_part.dart';

class MovieDetailStackOnPoster extends StatelessWidget {
  final String tagName;
  final Movie movie;

  const MovieDetailStackOnPoster({
    super.key,
    required this.tagName,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkTheme
        ? Colors.black.withOpacity(0.6)
        : Colors.black.withOpacity(0.3);
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Stack(
        children: [
          const PosterBackButton(),
          MoviePoster(
            tagName: tagName,
            posterPath: movie.posterPath,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: Container(
                color: bgColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 5,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: movie.voteAverage != null
                              ? MediaQuery.of(context).size.width * 0.75
                              : MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              PosterMiddlePart(movie: movie),
                              const Divider(),
                            ],
                          ),
                        ),
                        if (movie.voteAverage != null)
                          MovieAverageVote(
                            voteAverage: movie.voteAverage!,
                          ),
                      ],
                    ),
                    MoviePosterGenres(
                      genres: movie.genres.toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Divider extends StatelessWidget {
  const Divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 5);
  }
}
