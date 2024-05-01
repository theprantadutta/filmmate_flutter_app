import 'package:isar/isar.dart';

import 'movie.dart';

part '../generated/entities/movie_credit.g.dart';

@collection
class MovieCredit {
  Id autoId = Isar.autoIncrement;

  late int id;
  late List<String> writers;
  late List<String> storyBy;
  late List<String> directors;
  late List<String> producers;
  late List<String> musicBy;

  @Backlink(to: 'movieCredit')
  final movie = IsarLink<Movie>();
}
