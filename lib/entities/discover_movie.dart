import 'package:isar/isar.dart';

import 'movie.dart';

part '../generated/entities/discover_movie.g.dart';

@collection
class DiscoverMovie {
  Id autoId = Isar.autoIncrement;

  final movie = IsarLink<Movie>();
}
