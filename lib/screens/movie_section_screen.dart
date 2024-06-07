import 'package:flutter/material.dart';

import '../../screen_arguments/movie_section_screen_arguments.dart';

class MovieSectionScreen extends StatelessWidget {
  static const kRouteName = '/movie-section';
  const MovieSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as MovieSectionScreenArguments;
    return Container(
      child: Text(
        args.movieType.toString(),
      ),
    );
  }
}
