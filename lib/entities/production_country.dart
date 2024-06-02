import 'package:isar/isar.dart';

import 'movie_detail.dart';

part '../generated/entities/production_country.g.dart';

@collection
class ProductionCountry {
  Id id = Isar.autoIncrement;

  late String name;

  @Backlink(to: 'productionCountries')
  final movieDetail = IsarLink<MovieDetail>();
}
