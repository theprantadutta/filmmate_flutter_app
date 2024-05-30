import '../entities/movie.dart';

class MovieDetailScreenArguments {
  final Movie movie;
  final String tagName;

  MovieDetailScreenArguments({
    required this.movie,
    required this.tagName,
  });
}
