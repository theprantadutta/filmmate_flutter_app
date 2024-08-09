import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../components/common/vertical_movie_section.dart';
import '../../components/home/genres_section.dart';
import '../../components/layouts/main_layout.dart';
import '../components/common/main_layout_header.dart';
import '../components/common/something_went_wrong.dart';
import '../dtos/genre_dto.dart';
import '../dtos/movie_dto.dart';
import '../screen_arguments/genre_screen_arguments.dart';
import '../services/database_service.dart';
import '../services/movie_service.dart';
import '../util/default_entities.dart';
import '../util/functions.dart';

class GenreScreen extends StatefulWidget {
  static const kRouteName = '/genre';

  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  GenreDto? currentGenre = kDefaultGenre;
  List<GenreDto> allGenres = [];
  List<MovieDto> genreWiseMovies = [];
  bool fetchingMovies = false;
  bool fetchingAdditionalMovies = false;
  int pageNumber = 1;
  bool reachedEndOfMovies = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    getAllGenreFromDatabase();
    Future.delayed(Duration.zero, setInitialGenre);
  }

  setInitialGenre() {
    final args =
        ModalRoute.of(context)!.settings.arguments as GenreScreenArguments;
    setState(() => currentGenre = args.genre);
    setGenreWiseMovies(args.genre);
  }

  getAllGenreFromDatabase() async {
    final allGenresFromDb = await DatabaseService().getAllGenresFromDatabase();
    setState(() => allGenres = allGenresFromDb);
  }

  setGenreWiseMovies(GenreDto? genre) async {
    setState(() => fetchingMovies = true);
    try {
      final genreWiseMoviesFromDb = await MovieService.getMoviesByGenreId(
        genre?.id,
      );
      setState(() {
        genreWiseMovies = genreWiseMoviesFromDb.movies;
        hasError = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(
          'Something Went Wrong When Getting Movies in Genre Screen',
        );
      }
      setState(() {
        hasError = true;
      });
    } finally {
      setState(() {
        fetchingMovies = false;
      });
    }
  }

  changeCurrentGenre(GenreDto selectedGenre) {
    setState(
      () => currentGenre = selectedGenre,
    );
    setGenreWiseMovies(selectedGenre);
  }

  setAdditionalGenreWiseMovies() async {
    if (reachedEndOfMovies) {
      return;
    }
    setState(() {
      fetchingAdditionalMovies = true;
      pageNumber = pageNumber + 1;
    });
    final genreWiseMoviesFromDb = await MovieService.getAllMoviesByGenreId(
      currentGenre?.id,
      pageNumber,
    );
    setState(() {
      genreWiseMovies.addAll(genreWiseMoviesFromDb.movies);
      fetchingAdditionalMovies = false;
      reachedEndOfMovies = !hasNextPage(genreWiseMoviesFromDb.pagination);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MainLayoutHeader(
              title: currentGenre != null ? currentGenre!.name : 'All Genre',
              fetching: fetchingAdditionalMovies,
            ),
            if (!fetchingMovies)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 10,
                ),
                child: GenresSection(
                  genres: allGenres,
                  selectedGenre: currentGenre,
                  goWhenClicked: false,
                  onPressed: changeCurrentGenre,
                ),
              ),
            if (fetchingMovies)
              const Skeletonizer(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 10,
                  ),
                  child: GenresSectionSkeletor(),
                ),
              ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.8,
              child: fetchingMovies
                  ? const Skeletonizer(
                      child: VerticalMovieSectionSkeletor(),
                    )
                  : hasError
                      ? SomethingWentWrong(
                          onPressed: setInitialGenre,
                        )
                      : VerticalMovieSection(
                          movies: genreWiseMovies,
                          onLastItemReached: setAdditionalGenreWiseMovies,
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
