import 'package:isar/isar.dart';

import 'movie_detail.dart';

part '../generated/entities/movie_credit.g.dart';

@collection
class MovieCredit {
  Id id = Isar.autoIncrement;

  late List<String> writers;
  late List<String> storyBy;
  late List<String> directors;
  late List<String> producers;
  late List<String> musicBy;

  @Backlink(to: 'movieCredit')
  final movieDetail = IsarLink<MovieDetail>();
}
