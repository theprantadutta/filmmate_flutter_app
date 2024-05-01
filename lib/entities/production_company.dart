import 'package:isar/isar.dart';

import 'movie.dart';

part '../generated/entities/production_company.g.dart';

@collection
class ProductionCompany {
  Id autoId = Isar.autoIncrement;

  late int id;
  late String? logoPath;
  late String name;
  late String originCountry;

  @Backlink(to: 'productionCompanies')
  final movie = IsarLink<Movie>();
}
