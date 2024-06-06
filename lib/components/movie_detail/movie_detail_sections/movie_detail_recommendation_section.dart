import 'package:animate_do/animate_do.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../entities/movie.dart';
import '../../../screen_arguments/movie_detail_screen_arguments.dart';
import '../../../screens/movie_detail_screen.dart';
import '../../common/movie_section_cached_movie_image.dart';

class MovieDetailRecommendationSection extends StatelessWidget {
  final List<Movie> recommendedMovies;

  const MovieDetailRecommendationSection({
    super.key,
    required this.recommendedMovies,
  });

  List<Widget> getAllRecommendedMovies(BuildContext context) {
    List<Widget> allRecommendedMovies = [];
    recommendedMovies.forEachIndexed((index, movie) {
      // final movie = recommendedMovies[index];
      final tagName = '${movie.title}-${movie.posterPath}';
      allRecommendedMovies.add(
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
    return allRecommendedMovies;
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
      children: getAllRecommendedMovies(context),
    );
  }
}
