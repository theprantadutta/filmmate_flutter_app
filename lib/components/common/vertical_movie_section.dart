import 'package:animate_do/animate_do.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../entities/movie.dart';
import '../../screen_arguments/movie_detail_screen_arguments.dart';
import '../../screens/movie_detail_screen.dart';
import '../movie_detail/movie_poster/movie_average_vote.dart';
import 'movie_section_cached_movie_image.dart';

// class VerticalMovieSection extends StatefulWidget {
//   final List<Movie> movies;
//   final void Function()? onLastItemReached;

//   const VerticalMovieSection({
//     super.key,
//     required this.movies,
//     this.onLastItemReached,
//   });

//   @override
//   State<VerticalMovieSection> createState() => _VerticalMovieSectionState();
// }

// class _VerticalMovieSectionState extends State<VerticalMovieSection> {
//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels ==
//           _scrollController.position.maxScrollExtent) {
//         if (widget.onLastItemReached != null) {
//           widget.onLastItemReached!();
//         }
//       }
//     });
//   }

//   List<Widget> getAllMovies(BuildContext context) {
//     List<Widget> allMovies = [];
//     widget.movies.forEachIndexed((index, movie) {
//       // final movie = recommendedMovies[index];
//       final tagName = '${movie.title}-${movie.posterPath}';
//       allMovies.add(
//         Column(
//           children: [
//             Stack(
//               children: [
//                 Hero(
//                   tag: tagName,
//                   child: GestureDetector(
//                     onTap: () => Navigator.pushNamed(
//                       context,
//                       MovieDetailScreen.kRouteName,
//                       arguments: MovieDetailScreenArguments(
//                         movie: movie,
//                         tagName: tagName,
//                       ),
//                     ),
//                     child: MovieSectionCachedMovieImage(
//                         imageUrl:
//                             'https://image.tmdb.org/t/p/w500/${movie.posterPath}'),
//                   ),
//                 ),
//                 if (movie.voteAverage != null && movie.voteAverage != 0.0)
//                   Positioned(
//                     top: 0,
//                     right: -10,
//                     child: MovieAverageVote(
//                       voteAverage: movie.voteAverage!,
//                       isSmall: true,
//                     ),
//                   ),
//               ],
//             ),
//             FadeInUp(
//               duration: Duration(milliseconds: (index + 1) * 200),
//               child: Center(
//                 child: Text(
//                   movie.title,
//                   softWrap: true,
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//     return allMovies;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       controller: _scrollController,
//       padding: const EdgeInsets.only(
//         top: 10,
//         left: 0,
//         right: 0,
//         bottom: 10,
//       ),
//       childAspectRatio: 0.7,
//       crossAxisCount: 2,
//       mainAxisSpacing: 4,
//       crossAxisSpacing: 8,
//       children: getAllMovies(context),
//     );
//   }
// }

class VerticalMovieSection extends StatefulWidget {
  final List<Movie> movies;
  final void Function()? onLastItemReached;

  const VerticalMovieSection({
    super.key,
    required this.movies,
    this.onLastItemReached,
  });

  @override
  State<VerticalMovieSection> createState() => _VerticalMovieSectionState();
}

class _VerticalMovieSectionState extends State<VerticalMovieSection> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (widget.onLastItemReached != null) {
          widget.onLastItemReached!();
        }
      }
    });
  }

  List<Widget> getAllMovies(BuildContext context) {
    List<Widget> allMovies = [];
    widget.movies.forEachIndexed((index, movie) {
      final tagName = '${movie.title}-${movie.posterPath}';
      allMovies.add(
        Container(
          width: MediaQuery.of(context).size.width * 0.45, // Adjust width
          margin: const EdgeInsets.all(4.0),
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
                              'https://image.tmdb.org/t/p/w500/${movie.posterPath}'),
                    ),
                  ),
                  if (movie.voteAverage != null && movie.voteAverage != 0.0)
                    Positioned(
                      top: 0,
                      right: -10,
                      child: MovieAverageVote(
                        voteAverage: movie.voteAverage!,
                        isSmall: true,
                      ),
                    ),
                ],
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
        ),
      );
    });
    return allMovies;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> movieWidgets = getAllMovies(context);
    List<Row> rows = [];
    int itemsPerRow = 2;

    for (int i = 0; i < movieWidgets.length; i += itemsPerRow) {
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: movieWidgets.sublist(
            i,
            (i + itemsPerRow) > movieWidgets.length
                ? movieWidgets.length
                : (i + itemsPerRow),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.only(
        top: 10,
        left: 0,
        right: 0,
        bottom: 10,
      ),
      child: Column(
        children: rows,
      ),
    );
  }
}
