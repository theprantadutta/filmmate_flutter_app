import 'dart:async';

import 'package:filmmate_flutter_app/dtos/genre_dto.dart';
import 'package:filmmate_flutter_app/dtos/movie_detail_dto.dart';
import 'package:flutter/foundation.dart';

import '../constants/urls.dart';
import '../dtos/movie_response_dto.dart';
import '../models/home_screen_response.dart';
import 'http_service.dart';
import 'movie_service.dart';
import 'parser_background_service.dart';

class DatabaseService {
  Future<MovieDetailDto> getMovieDetailFromDatabase(int movieId) async {
    var url = '$kApiUrl/$kGetMovieDetail?movieId=$movieId';
    var response = await HttpService.get(url);
    if (response.statusCode == 200) {
      // Use compute to parse the response body in a background isolate
      return await ParserBackgroundService.parseMovieDetailResponseInBackground(
        response.data,
      );
    } else {
      debugPrint('UrlPath: $url, Status Code: ${response.statusCode}');
      debugPrint('Reason: ${response.statusMessage}');
      throw Exception(response.statusMessage);
    }
  }

  Future<HomeScreenResponse> getAllHomeScreenData() async {
    final genresFuture = getAllGenresFromDatabase();
    final discoverMoviesFuture = MovieService.getDiscoverMovies();
    final nowPlayingMoviesFuture = MovieService.getNowPlayingMovies();
    final popularMoviesFuture = MovieService.getPopularMovies();
    final topRatedMoviesFuture = MovieService.getTopRatedMovies();
    final upcomingMoviesFuture = MovieService.getUpcomingMovies();

    try {
      // Wait for both futures to complete
      final response = await Future.wait([
        genresFuture,
        discoverMoviesFuture,
        nowPlayingMoviesFuture,
        popularMoviesFuture,
        topRatedMoviesFuture,
        upcomingMoviesFuture,
      ]);
      return HomeScreenResponse(
        genres: response[0] as List<GenreDto>,
        discoverMovies: response[1] as MovieResponseDto,
        nowPlayings: response[2] as MovieResponseDto,
        popularMovies: response[3] as MovieResponseDto,
        topRatedMovies: response[4] as MovieResponseDto,
        upcomingMovies: response[5] as MovieResponseDto,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Something Went Wrong When Fetching all Movies Future');
        print(e);
      }
      rethrow;
    }
  }

  Future<MovieResponseDto> getSomeMoviesFromDatabase({
    required String urlPath,
    int pageNumber = 1,
  }) async {
    var url = '$kApiUrl/$urlPath?pageNumber=$pageNumber';
    var response = await HttpService.get(url);
    if (response.statusCode == 200) {
      // Use compute to parse the response body in a background isolate
      return await ParserBackgroundService.parseMovieResponseInBackground(
        response.data,
      );
    } else {
      debugPrint('UrlPath: $urlPath, Status Code: ${response.statusCode}');
      debugPrint('Reason: ${response.statusMessage}');
      throw Exception(response.statusMessage);
    }
  }

  Future<List<GenreDto>> getAllGenresFromDatabase() async {
    var url = '$kApiUrl/$kGetAllGenres';
    var response = await HttpService.get(url);
    if (response.statusCode == 200) {
      // log(response.body);
      // Use compute to parse the response body in a background isolate
      final allDbGenres =
          await ParserBackgroundService.parseGenresResponseInBackground(
        response.data,
      );
      return allDbGenres;
    } else {
      debugPrint(
          'UrlPath: $kGetAllGenres, Status Code: ${response.statusCode}');
      debugPrint('Reason: ${response.statusMessage}');
      throw Exception(response.statusMessage);
    }
  }

  Future<MovieResponseDto> fetchMoviesByGenreId({
    int? genreId,
    int pageNumber = 1,
  }) async {
    var url = '$kApiUrl/$kGetGenreWiseMovies?pageNumber=$pageNumber';
    if (genreId != null) {
      url += '&genreId=$genreId';
    }
    var response = await HttpService.get(url);
    if (response.statusCode == 200) {
      // Use compute to parse the response body in a background isolate
      return await ParserBackgroundService.parseMovieResponseInBackground(
        response.data,
      );
    } else {
      debugPrint(
          'UrlPath: $kGetGenreWiseMovies, Status Code: ${response.statusCode}');
      debugPrint('Reason: ${response.statusMessage}');
      throw Exception(response.statusMessage);
    }
  }

  Future<MovieResponseDto> searchMoviesByTitle(String title) async {
    var url = '$kApiUrl/$kGetSearchMovies?title=${Uri.encodeComponent(title)}';
    var response = await HttpService.get(url);
    if (response.statusCode == 200) {
      // Use compute to parse the response body in a background isolate
      return await ParserBackgroundService.parseMovieResponseInBackground(
        response.data,
      );
    } else {
      debugPrint(
          'UrlPath: $kGetSearchMovies, Status Code: ${response.statusCode}');
      debugPrint('Reason: ${response.statusMessage}');
      throw Exception(response.statusMessage);
    }
  }
}
