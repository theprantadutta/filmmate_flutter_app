import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../components/common/movie_section_cached_movie_image.dart';
import '../../../entities/single_image.dart';

class MovieDetailPosters extends StatelessWidget {
  const MovieDetailPosters({
    super.key,
    required this.posters,
  });

  final List<SingleImage> posters;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: posters.length,
        itemBuilder: (context, index) {
          final poster = posters[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.5,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: MovieSectionCachedMovieImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500/${poster.filePath!}',
            ),
          );
        },
      ),
    );
  }
}
