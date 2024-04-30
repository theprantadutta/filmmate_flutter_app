import 'cast.dart';
import 'genre.dart';
import 'images.dart';
import 'movie_credit.dart';
import 'production_company.dart';
import 'production_country.dart';
import 'spoken_language.dart';
import 'video.dart';

class Movie {
  bool adult;
  String? backdropPath;
  int budget;
  String? homePage;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String overView;
  String? posterPath;
  String? releaseDate;
  int revenue;
  int runtime;
  String status;
  String tagline;
  String title;
  List<Genre> genres;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  List<SpokenLanguage> spokenLanguages;
  List<Cast> casts;
  MovieCredit movieCredit;
  Images images;
  List<Video> videos;
  int orderBy;

  Movie({
    required this.adult,
    required this.overView,
    required this.budget,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.genres,
    required this.productionCompanies,
    required this.productionCountries,
    required this.spokenLanguages,
    required this.casts,
    required this.movieCredit,
    required this.images,
    required this.videos,
    required this.orderBy,
    this.backdropPath,
    this.homePage,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.releaseDate,
  });
}
