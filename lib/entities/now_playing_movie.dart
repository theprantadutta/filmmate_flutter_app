import 'package:isar/isar.dart';

import 'movie.dart';

part '../generated/entities/now_playing_movie.g.dart';

@collection
class NowPlayingMovie {
  Id id = Isar.autoIncrement;

  final movie = IsarLink<Movie>();
}
