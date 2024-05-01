import 'package:isar/isar.dart';

import 'movie.dart';

part '../generated/entities/production_country.g.dart';

@collection
class ProductionCountry {
  Id autoId = Isar.autoIncrement;

  late int id;
  late String name;

  @Backlink(to: 'productionCountries')
  final movie = IsarLink<Movie>();
}
