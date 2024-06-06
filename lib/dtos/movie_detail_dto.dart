import 'package:json_annotation/json_annotation.dart';

import 'cast_dto.dart';
import 'genre_dto.dart';
import 'images_dto.dart';
import 'movie_credit_dto.dart';
import 'movie_dto.dart';
import 'production_company_dto.dart';
import 'production_country_dto.dart';
import 'spoken_language_dto.dart';
import 'video_dto.dart';

part '../generated/dtos/movie_detail_dto.g.dart';

@JsonSerializable()
class MovieDetailDto {
  final int id;
  final bool adult;
  String? backdropPath;
  int? budget;
  String? homePage;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  final String overView;

  String? posterPath;
  String? releaseDate;

  int? revenue;
  int? runtime;
  final String status;
  String? tagline;

  final String title;

  final List<GenreDto> genres;
  final List<ProductionCompanyDto> productionCompanies;
  final List<ProductionCountryDto> productionCountries;
  final List<SpokenLanguageDto> spokenLanguages;
  final List<CastDto> casts;
  final MovieCreditDto movieCredit;
  final ImagesDto images;
  final List<VideoDto> videos;

  final List<MovieDto> recommendedMovies;

  MovieDetailDto({
    required this.id,
    required this.adult,
    required this.title,
    required this.genres,
    this.backdropPath,
    this.posterPath,
    this.releaseDate,
    required this.overView,
    this.budget,
    this.revenue,
    this.runtime,
    required this.status,
    required this.tagline,
    required this.productionCompanies,
    required this.productionCountries,
    required this.spokenLanguages,
    required this.casts,
    required this.movieCredit,
    required this.images,
    required this.videos,
    this.homePage,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    required this.recommendedMovies,
  });

  /// Connect the generated [_$MovieDtoFromJson] function to the `fromJson`
  /// factory.
  factory MovieDetailDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailDtoFromJson(json);

  /// Connect the generated [_$CastDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MovieDetailDtoToJson(this);
}
