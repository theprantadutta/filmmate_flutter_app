import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../components/common/vertical_movie_section.dart';
import '../../components/home/genres_section.dart';
import '../../components/layouts/main_layout.dart';
import '../../services/isar_service.dart';
import '../constants/colors.dart';
import '../entities/genre.dart';
import '../entities/movie.dart';
import '../screen_arguments/genre_screen_arguments.dart';
import '../services/movie_service.dart';
import '../util/default_entities.dart';

class GenreScreen extends StatefulWidget {
  static const kRouteName = '/genre';

  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  Genre currentGenre = kDefaultGenre;
  List<Genre> allGenres = [];
  List<Movie> genreWiseMovies = [];
  bool fetchingMovies = false;

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
    final allGenresFromDb = await IsarService().getAllGenresFromLocalDb();
    setState(() => allGenres = allGenresFromDb);
  }

  setGenreWiseMovies(Genre genre) async {
    setState(() => fetchingMovies = true);
    // await Future.delayed(const Duration(seconds: 5));
    final genreWiseMoviesFromDb =
        await MovieService.getMoviesByGenreId(genre.id);
    setState(() {
      genreWiseMovies = genreWiseMoviesFromDb;
      fetchingMovies = false;
    });
    setState(() => genreWiseMovies = genreWiseMoviesFromDb);
  }

  changeCurrentGenre(Genre selectedGenre) {
    setState(
      () => currentGenre = selectedGenre,
    );
    setGenreWiseMovies(selectedGenre);
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Genres',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.4,
              ),
            ),
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
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.8,
              child: fetchingMovies
                  ? Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: kPrimaryColor,
                        size: 50,
                      ),
                    )
                  : VerticalMovieSection(
                      movies: genreWiseMovies,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
