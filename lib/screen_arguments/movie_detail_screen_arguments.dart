import '../dtos/movie_dto.dart';

class MovieDetailScreenArguments {
  final MovieDto movie;
  final String tagName;

  MovieDetailScreenArguments({
    required this.movie,
    required this.tagName,
  });
}
