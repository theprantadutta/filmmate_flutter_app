import 'package:isar/isar.dart';

import 'discover_movie.dart';
import 'genre.dart';
import 'movie_detail.dart';
import 'now_playing_movie.dart';
import 'popular_movie.dart';
import 'top_rated_movie.dart';
import 'upcoming_movie.dart';

part '../generated/entities/movie.g.dart';

@collection
class Movie {
  Id autoId = Isar.autoIncrement;

  late int id;
  late bool adult;
  String? backdropPath;

  String? posterPath;
  DateTime? releaseDate;
  String? certification;
  late String title;
  late int orderBy;
  late double? voteAverage;

  final genres = IsarLinks<Genre>();
  final movieDetail = IsarLink<MovieDetail>();

  @Backlink(to: 'movie')
  final discoverMovie = IsarLink<DiscoverMovie>();
  @Backlink(to: 'movie')
  final nowPlayingMovie = IsarLink<NowPlayingMovie>();
  @Backlink(to: 'movie')
  final popularMovie = IsarLink<PopularMovie>();
  @Backlink(to: 'movie')
  final topRatedMovie = IsarLink<TopRatedMovie>();
  @Backlink(to: 'movie')
  final upcomingMovie = IsarLink<UpcomingMovie>();
}
