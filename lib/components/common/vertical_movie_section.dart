import 'package:animate_do/animate_do.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../entities/movie.dart';
import '../../screen_arguments/movie_detail_screen_arguments.dart';
import '../../screens/movie_detail_screen.dart';
import 'movie_section_cached_movie_image.dart';

class VerticalMovieSection extends StatelessWidget {
  final List<Movie> movies;
  const VerticalMovieSection({super.key, required this.movies});

  List<Widget> getAllMovies(BuildContext context) {
    List<Widget> allMovies = [];
    movies.forEachIndexed((index, movie) {
      // final movie = recommendedMovies[index];
      final tagName = '${movie.title}-${movie.posterPath}';
      allMovies.add(
        Column(
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
                        'https://image.tmdb.org/t/p/w500/${movie.posterPath}'),
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: (index + 1) * 200),
              child: Center(
                child: Text(
                  movie.title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      );
    });
    return allMovies;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.only(
        top: 10,
        left: 0,
        right: 0,
        bottom: 10,
      ),
      childAspectRatio: 0.7,
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 8,
      children: getAllMovies(context),
    );
  }
}
