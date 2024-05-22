import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../components/movie_detail/movie_detail_another_section.dart';
import '../components/movie_detail/movie_detail_section.dart';
import '../components/movie_detail/movie_detail_stack_on_poster.dart';
import '../constants/colors.dart';
import '../screen_arguments/movie_detail_screen_arguments.dart';
import '../services/database_service.dart';

class MovieDetailScreen extends StatelessWidget {
  static const kRouteName = '/movie-detail';

  const MovieDetailScreen({super.key});

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
                FutureBuilder(
                  future:
                      DatabaseService().getMovieDetailFromDatabase(movie.id),
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
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MovieDetailAnotherSection(
                            title: 'Status',
                            value: movieDetail.status,
                          ),
                          MovieDetailAnotherSection(
                            title: 'Release Date',
                            value: movieDetail.releaseDate ?? 'N/A',
                          ),
                          MovieDetailSection(
                            title: 'Tagline',
                            value: movieDetail.tagline,
                          ),
                          MovieDetailSection(
                            title: 'Overview',
                            value: movieDetail.overView,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
