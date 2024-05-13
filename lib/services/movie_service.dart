import 'package:flutter/foundation.dart';

import '../constants/urls.dart';
import '../dtos/movie_response_dto.dart';
import 'database_service.dart';

class MovieService {
  static Future<MovieResponseDto> getDiscoverMovies() async {
    try {
      final discoverMovies = await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetDiscoverMovies,
      );
      // final isar = await IsarService().openDB();
      // await isar.writeTxn(() => isar.discoverMovies.clear());
      // List<Movie> allSavedDiscoverMovies =
      //     await IsarService().saveSomeMovies(discoverMovies.movies);
      // // List<DiscoverMovie> discoverMoviesForIsar = [];
      // for (var singleMovie in allSavedDiscoverMovies) {
      //   final movie = DiscoverMovie();
      //   movie.movie.value = singleMovie;
      //   // discoverMoviesForIsar.add(movie);
      //   // await isar.writeTxn(() => movie.movie.save());
      //   await isar.writeTxn(() async {
      //     // await movie.movie.save();
      //     await isar.discoverMovies.put(movie);
      //   });
      // }
      // await isar.writeTxn(() async {
      //   await isar.discoverMovies.putAll(discoverMoviesForIsar);
      // });
      return discoverMovies;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  static Future<MovieResponseDto> getNowPlayingMovies() async {
    try {
      final nowPlayingMovies =
          await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetNowPlayingMovies,
      );
      return nowPlayingMovies;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  static Future<MovieResponseDto> getPopularMovies() async {
    try {
      final popularMovies = await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetPopularMovies,
      );
      return popularMovies;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  static Future<MovieResponseDto> getTopRatedMovies() async {
    try {
      final topRatedMovies = await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetTopRatedMovies,
      );
      return topRatedMovies;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  static Future<MovieResponseDto> getUpcomingMovies() async {
    try {
      final upcomingMovies = await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetUpcomingMovies,
      );
      return upcomingMovies;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
