import 'package:isar/isar.dart';

import 'movie.dart';

part '../generated/entities/upcoming_movie.g.dart';

@collection
class UpcomingMovie {
  Id id = Isar.autoIncrement;

  final movie = IsarLink<Movie>();
}
