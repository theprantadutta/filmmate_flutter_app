import 'package:isar/isar.dart';

import 'cast.dart';
import 'genre.dart';
import 'images.dart';
import 'movie_credit.dart';
import 'production_company.dart';
import 'production_country.dart';
import 'spoken_language.dart';
import 'video.dart';

part '../generated/entities/movie.g.dart';

@collection
class Movie {
  Id autoId = Isar.autoIncrement;

  late bool adult;
  String? backdropPath;
  late int budget;
  String? homePage;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  late String overView;
  String? posterPath;
  String? releaseDate;
  late int revenue;
  late int runtime;
  late String status;
  late String tagline;
  late String title;
  late int orderBy;

  final genres = IsarLinks<Genre>();
  final productionCompanies = IsarLinks<ProductionCompany>();
  final productionCountries = IsarLinks<ProductionCountry>();
  final spokenLanguages = IsarLinks<SpokenLanguage>();
  final casts = IsarLinks<Cast>();
  final movieCredit = IsarLink<MovieCredit>();
  final images = IsarLink<Images>();
  final videos = IsarLinks<Video>();

  // Movie({
  //   required this.adult,
  //   required this.overView,
  //   required this.budget,
  //   required this.revenue,
  //   required this.runtime,
  //   required this.status,
  //   required this.tagline,
  //   required this.title,
  //   // required this.genres,
  //   // required this.productionCompanies,
  //   // required this.productionCountries,
  //   // required this.spokenLanguages,
  //   // required this.casts,
  //   // required this.movieCredit,
  //   // required this.images,
  //   // required this.videos,
  //   required this.orderBy,
  //   this.backdropPath,
  //   this.homePage,
  //   this.imdbId,
  //   this.originalLanguage,
  //   this.originalTitle,
  //   this.posterPath,
  //   this.releaseDate,
  // });

  // /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  // /// factory.
  // factory Movie.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  // /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  // Map<String, dynamic> toJson() => _$PersonToJson(this);
}
