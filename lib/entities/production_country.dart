import 'package:isar/isar.dart';

import 'movie_detail.dart';

part '../generated/entities/production_country.g.dart';

@collection
class ProductionCountry {
  Id autoId = Isar.autoIncrement;

  late int id;
  late String name;

  @Backlink(to: 'productionCountries')
  final movieDetail = IsarLink<MovieDetail>();
}
