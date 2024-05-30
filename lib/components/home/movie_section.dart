import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../components/common/movie_section_cached_movie_image.dart';
import '../../entities/movie.dart';
import '../../screen_arguments/movie_detail_screen_arguments.dart';
import '../../screens/movie_detail_screen.dart';
import 'movie_section/movie_section_top_bar.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MovieSectionTopBar(
          title: title,
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
              return Column(
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
              );
            },
          ),
        ),
      ],
    );
  }
}
