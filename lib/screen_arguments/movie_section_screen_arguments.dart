import '../enums/movie_type.dart';

class MovieSectionScreenArguments {
  final MovieType movieType;
  final String title;

  MovieSectionScreenArguments({
    required this.movieType,
    required this.title,
  });
}
