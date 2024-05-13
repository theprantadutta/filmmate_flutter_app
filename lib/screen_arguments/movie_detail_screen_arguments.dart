import 'package:filmmate_flutter_app/dtos/movie_dto.dart';

class MovieDetailScreenArguments {
  final MovieDto movie;
  final String tagName;

  MovieDetailScreenArguments({
    required this.movie,
    required this.tagName,
  });
}
