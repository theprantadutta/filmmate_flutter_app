import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../components/common/movie_section_cached_movie_image.dart';
import '../../dtos/movie_dto.dart';
import '../../enums/movie_type.dart';
import '../../screen_arguments/movie_detail_screen_arguments.dart';
import '../../screens/movie_detail_screen.dart';
import '../movie_detail/movie_poster/movie_average_vote.dart';
import 'movie_section/movie_section_top_bar.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<MovieDto> movies;
  final MovieType movieType;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    required this.movieType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: MovieSectionTopBar(
            title: title,
            movieType: movieType,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              final tagName = '$title-${movie.posterPath}';
              return FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: tagName,
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              MovieDetailScreen.kRouteName,
                              arguments: MovieDetailScreenArguments(
                                movie: movie,
                                tagName: tagName,
                              ),
                            ),
                            child: MovieSectionCachedMovieImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                            ),
                          ),
                        ),
                        if (movie.voteAverage != null)
                          Positioned(
                            top: 8,
                            right: -12,
                            child: MovieAverageVote(
                              voteAverage: movie.voteAverage!,
                              isSmall: true,
                            ),
                          ),
                      ],
                    ),
                    FadeInUp(
                      duration:
                          Duration(milliseconds: (min(index, 5) + 1) * 200),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.39,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Center(
                          child: Text(
                            movie.title,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MovieSectionSkeletor extends StatelessWidget {
  const MovieSectionSkeletor({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: const MovieSectionTopBarSkeletor(),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const MovieSectionCachedMovieImageSkeletor(),
                        ),
                        const Positioned(
                          top: 8,
                          right: -12,
                          child: MovieAverageVote(
                            voteAverage: 99,
                            isSmall: true,
                          ),
                        ),
                      ],
                    ),
                    FadeInUp(
                      duration:
                          Duration(milliseconds: (min(index, 5) + 1) * 200),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.39,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: const Center(
                          child: Text(
                            'Some Really Long Title',
                            softWrap: true,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
