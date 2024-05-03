import 'package:isar/isar.dart';

import 'movie_detail.dart';

part '../generated/entities/spoken_language.g.dart';

@collection
class SpokenLanguage {
  Id autoId = Isar.autoIncrement;

  late String englishName;
  late String name;

  @Backlink(to: 'spokenLanguages')
  final movieDetail = IsarLink<MovieDetail>();
}
