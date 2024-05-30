import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/colors.dart';
import '../../entities/movie.dart';
import '../../services/database_service.dart';
import 'movie_detail_sections/single_movie_section_buttons.dart';

class SingleMovieDetails extends StatefulWidget {
  const SingleMovieDetails({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  State<SingleMovieDetails> createState() => _SingleMovieDetailsState();
}

class _SingleMovieDetailsState extends State<SingleMovieDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().getMovieDetailFromDatabase(widget.movie.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 100,
            child: Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: kPrimaryColor,
                size: 40,
              ),
            ),
          );
        }
        if ((snapshot.hasError)) {
          if (kDebugMode) {
            print(snapshot.error);
          }
          return const SizedBox(
            height: 100,
            child: Center(
              child: Text('Something Went Wrong'),
            ),
          );
        }
        final movieDetail = snapshot.data!;
        return SingleMovieSectionButtons(
          movieDetail: movieDetail,
        );
      },
    );
  }
}
