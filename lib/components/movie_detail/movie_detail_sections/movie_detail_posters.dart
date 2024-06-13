import 'package:flutter/material.dart';

import '../../../components/common/movie_section_cached_movie_image.dart';
import '../../../entities/single_image.dart';

// class MovieDetailPosters extends StatelessWidget {
//   const MovieDetailPosters({
//     super.key,
//     required this.posters,
//   });

//   final List<SingleImage> posters;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       scrollDirection: Axis.vertical,
//       itemCount: posters.length,
//       itemBuilder: (context, index) {
//         final poster = posters[index];
//         return Container(
//           width: MediaQuery.of(context).size.width * 0.9,
//           height: MediaQuery.of(context).size.height * 0.5,
//           padding: const EdgeInsets.symmetric(vertical: 4),
//           child: MovieSectionCachedMovieImage(
//             imageUrl: 'https://image.tmdb.org/t/p/w500/${poster.filePath!}',
//           ),
//         );
//       },
//     );
//   }
// }

class MovieDetailPosters extends StatelessWidget {
  const MovieDetailPosters({
    super.key,
    required this.posters,
  });

  final List<SingleImage> posters;

  @override
  Widget build(BuildContext context) {
    List<Widget> posterWidgets = posters.map((poster) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: MovieSectionCachedMovieImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500/${poster.filePath!}',
        ),
      );
    }).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: posterWidgets,
      ),
    );
  }
}
