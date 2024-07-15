import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../components/common/movie_section_cached_movie_image.dart';
import '../../entities/movie.dart';
import '../../enums/movie_type.dart';
import '../../screen_arguments/movie_detail_screen_arguments.dart';
import '../../screens/movie_detail_screen.dart';
import '../movie_detail/movie_poster/movie_average_vote.dart';
import 'movie_section/movie_section_top_bar.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;
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
                      duration: Duration(milliseconds: (index + 1) * 200),
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
