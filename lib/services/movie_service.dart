import 'package:filmmate_flutter_app/entities/discover_movie.dart';
import 'package:filmmate_flutter_app/entities/movie.dart';
import 'package:filmmate_flutter_app/services/isar_service.dart';
import 'package:flutter/foundation.dart';

import '../constants/urls.dart';
import 'database_service.dart';

class MovieService {
  static Future<void> getDiscoverMovies() async {
    try {
      final discoverMovies = await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetDiscoverMovies,
      );
      final isar = await IsarService().openDB();
      List<Movie> allSavedDiscoverMovies =
          await IsarService().saveSomeMovies(discoverMovies.movies);
      List<DiscoverMovie> discoverMoviesForIsar = [];
      for (var singleMovie in allSavedDiscoverMovies) {
        discoverMoviesForIsar.add(DiscoverMovie()..movie.value = singleMovie);
      }
      await isar
          .writeTxn(() => isar.discoverMovies.putAll(discoverMoviesForIsar));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> getNowPlayingMovies() async {
    try {
      final nowPlayingMovies =
          await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetNowPlayingMovies,
      );
      print(nowPlayingMovies.movies.length);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> getPopularMovies() async {
    try {
      final popularMovies = await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetPopularMovies,
      );
      print(popularMovies.movies.length);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> getTopRatedMovies() async {
    try {
      final topRatedMovies = await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetTopRatedMovies,
      );
      print(topRatedMovies.movies.length);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> getUpcomingMovies() async {
    try {
      final upcomingMovies = await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetUpcomingMovies,
      );
      print(upcomingMovies.movies.length);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
