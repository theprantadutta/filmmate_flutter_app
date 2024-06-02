import 'package:isar/isar.dart';

import 'movie_detail.dart';

part '../generated/entities/production_company.g.dart';

@collection
class ProductionCompany {
  Id id = Isar.autoIncrement;

  late String? logoPath;
  late String name;
  late String originCountry;

  @Backlink(to: 'productionCompanies')
  final movieDetail = IsarLink<MovieDetail>();
}
