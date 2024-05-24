import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/movie_detail/movie_detail_stack_on_poster.dart';
import '../components/movie_detail/single_movie_details.dart';
import '../screen_arguments/movie_detail_screen_arguments.dart';

class MovieDetailScreen extends StatelessWidget {
  static const kRouteName = '/movie-detail';

  const MovieDetailScreen({super.key});

  // late String _selected = allSections[0];
  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments
        as MovieDetailScreenArguments;
    final movie = args.movie;
    return Scaffold(
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieDetailStackOnPoster(tagName: args.tagName, movie: movie),
                SingleMovieDetails(movie: movie),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
