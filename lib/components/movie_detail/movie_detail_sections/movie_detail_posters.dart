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
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: posters.length,
        itemBuilder: (context, index) {
          final poster = posters[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.3,
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: MovieSectionCachedMovieImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500/${poster.filePath!}',
            ),
          );
        },
      ),
    );
  }
}
