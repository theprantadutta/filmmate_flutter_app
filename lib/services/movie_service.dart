import 'package:flutter/foundation.dart';

import '../constants/urls.dart';
import '../dtos/movie_response_dto.dart';
import 'database_service.dart';

class MovieService {
  static Future<MovieResponseDto> getDiscoverMovies() async {
    try {
      // Fetch a list of movies from the database using the specified URL path.
      return await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetDiscoverMovies,
      );
    } catch (e) {
      // If in debug mode, print the error message to the console.
      if (kDebugMode) {
        print(e);
      }

      // Rethrow the exception to be handled by the calling code.
      rethrow;
    }
  }

  static Future<MovieResponseDto> getNowPlayingMovies() async {
    try {
      return await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetNowPlayingMovies,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  static Future<MovieResponseDto> getPopularMovies() async {
    try {
      return await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetPopularMovies,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  static Future<MovieResponseDto> getTopRatedMovies() async {
    try {
      return await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetTopRatedMovies,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  static Future<MovieResponseDto> getUpcomingMovies() async {
    try {
      return await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetUpcomingMovies,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  static Future<MovieResponseDto> getMoviesByGenreId(int? genreId) async {
    try {
      return await DatabaseService().fetchMoviesByGenreId(
        genreId: genreId,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  static Future<MovieResponseDto> getAllMoviesByGenreId(
      int? genreId, pageNumber) async {
    try {
      return await DatabaseService().fetchMoviesByGenreId(
        genreId: genreId,
        pageNumber: pageNumber,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
