import 'package:isar/isar.dart';

import '../../entities/movie.dart';
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
  Id id = Isar.autoIncrement;

  int? budget;
  String? homePage;
  String? imdbId;

  String? originalLanguage;
  String? originalTitle;
  late String overView;

  int? revenue;
  int? runtime;
  late String status;
  late String? tagline;

  late String? awards;
  late String? imdbRating;
  late String? rottenTomatoesScore;
  late String? metaCriticScore;

  @Backlink(to: 'movieDetail')
  final movie = IsarLink<Movie>();

  final recommendedMovies = IsarLinks<Movie>();

  final productionCompanies = IsarLinks<ProductionCompany>();
  final productionCountries = IsarLinks<ProductionCountry>();
  final spokenLanguages = IsarLinks<SpokenLanguage>();
  final casts = IsarLinks<Cast>();
  final movieCredit = IsarLink<MovieCredit>();
  final images = IsarLink<Images>();
  final videos = IsarLinks<Video>();
}
