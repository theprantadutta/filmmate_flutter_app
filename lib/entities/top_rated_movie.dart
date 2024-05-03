import 'package:isar/isar.dart';

import 'movie.dart';

part '../generated/entities/top_rated_movie.g.dart';

@collection
class TopRatedMovie {
  Id autoId = Isar.autoIncrement;

  final movie = IsarLink<Movie>();
}
