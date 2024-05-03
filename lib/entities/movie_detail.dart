import 'package:filmmate_flutter_app/entities/movie.dart';
import 'package:isar/isar.dart';

import 'cast.dart';
import 'images.dart';
import 'movie_credit.dart';
import 'production_company.dart';
import 'production_country.dart';
import 'spoken_language.dart';
import 'video.dart';

part '../generated/entities/movie_detail.g.dart';

@collection
class MovieDetail {
  Id autoId = Isar.autoIncrement;

  late int budget;
  String? homePage;
  String? imdbId;

  String? originalLanguage;
  String? originalTitle;
  late String overView;

  late int revenue;
  late int runtime;
  late String status;
  late String tagline;

  @Backlink(to: 'movieDetail')
  final movie = IsarLink<Movie>();

  final productionCompanies = IsarLinks<ProductionCompany>();
  final productionCountries = IsarLinks<ProductionCountry>();
  final spokenLanguages = IsarLinks<SpokenLanguage>();
  final casts = IsarLinks<Cast>();
  final movieCredit = IsarLink<MovieCredit>();
  final images = IsarLink<Images>();
  final videos = IsarLinks<Video>();
}
