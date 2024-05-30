import 'package:isar/isar.dart';

import 'movie.dart';

part '../generated/entities/genre.g.dart';

@collection
class Genre {
  Id autoId = Isar.autoIncrement;

  late int id;
  late String name;

  @Backlink(to: 'genres')
  final movies = IsarLinks<Movie>();
}
