import 'package:isar/isar.dart';

import 'movie.dart';

part '../generated/entities/popular_movie.g.dart';

@collection
class PopularMovie {
  Id autoId = Isar.autoIncrement;

  final movie = IsarLink<Movie>();
}
