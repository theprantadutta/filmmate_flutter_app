import 'package:filmmate_flutter_app/components/common/main_layout_header.dart';
import 'package:filmmate_flutter_app/constants/urls.dart';
import 'package:filmmate_flutter_app/services/database_service.dart';
import 'package:filmmate_flutter_app/services/isar_service.dart';
import 'package:filmmate_flutter_app/util/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../screen_arguments/movie_section_screen_arguments.dart';
import '../components/common/something_went_wrong.dart';
import '../components/common/vertical_movie_section.dart';
import '../components/layouts/main_layout.dart';
import '../constants/colors.dart';
import '../entities/movie.dart';
import '../enums/movie_type.dart';

class MovieSectionScreen extends StatefulWidget {
  static const kRouteName = '/movie-section';
  const MovieSectionScreen({super.key});

  @override
  State<MovieSectionScreen> createState() => _MovieSectionScreenState();
}

class _MovieSectionScreenState extends State<MovieSectionScreen> {
  List<Movie> movieSectionMovies = [];
  bool fetchingMovies = false;
  bool fetchingAdditionalMovies = false;
  MovieType movieType = MovieType.discover;
  int pageNumber = 1;
  bool reachedEndOfMovies = false;
  bool hasError = false;

  Future<List<Movie>> getMovieSectionMoviesFromLocalDb() async {
    final args = ModalRoute.of(context)!.settings.arguments
        as MovieSectionScreenArguments;
    switch (args.movieType) {
      case MovieType.discover:
        return getSpecificMovieSectionData(kGetDiscoverMovies);
      case MovieType.popular:
        return getSpecificMovieSectionData(kGetPopularMovies);
      case MovieType.nowPlaying:
        return getSpecificMovieSectionData(kGetNowPlayingMovies);
      case MovieType.topRated:
        return getSpecificMovieSectionData(kGetTopRatedMovies);
      case MovieType.upcoming:
        return getSpecificMovieSectionData(kGetUpcomingMovies);
      default:
        return getSpecificMovieSectionData(kGetAllMoviesByGenre);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      setInitialMovies,
    );
  }

  Future<void> setInitialMovies() async {
    final args = ModalRoute.of(context)!.settings.arguments
        as MovieSectionScreenArguments;

    setState(() {
      movieType = args.movieType;
      fetchingMovies = true;
    });
    setMovieSectionMovies();
  }

  Future<void> setMovieSectionMovies() async {
    if (reachedEndOfMovies) {
      return;
    }
    setState(() {
      fetchingMovies = true;
    });
    final moviesFromDb = await getMovieSectionMoviesFromLocalDb();
    setState(() {
      movieSectionMovies = moviesFromDb;
      fetchingMovies = false;
    });
  }

  Future<void> setAdditionalMovies() async {
    setState(() {
      fetchingAdditionalMovies = true;
      pageNumber = pageNumber + 1;
    });
    final moviesFromDb = await getMovieSectionMoviesFromLocalDb();
    setState(() {
      movieSectionMovies.addAll(moviesFromDb);
      fetchingAdditionalMovies = false;
    });
  }

  Future<List<Movie>> getSpecificMovieSectionData(String urlPath) async {
    try {
      final movieSectionResponse =
          await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: urlPath,
        pageNumber: pageNumber,
      );
      final response =
          await IsarService().saveSomeMovies(movieSectionResponse.movies);
      setState(() {
        reachedEndOfMovies = !hasNextPage(movieSectionResponse.pagination);
        hasError = false;
      });
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        hasError = true;
      });
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as MovieSectionScreenArguments;
    return MainLayout(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            MainLayoutHeader(
              title: args.title,
              fetching: fetchingAdditionalMovies,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.9,
              child: fetchingMovies
                  ? Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: kPrimaryColor,
                        size: 50,
                      ),
                    )
                  : hasError
                      ? SomethingWentWrong(
                          onPressed: setMovieSectionMovies,
                        )
                      : VerticalMovieSection(
                          movies: movieSectionMovies,
                          onLastItemReached: setAdditionalMovies,
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
