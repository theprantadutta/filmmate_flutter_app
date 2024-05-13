import 'package:flutter/foundation.dart';

import '../constants/urls.dart';
import '../dtos/genre_dto.dart';
import '../dtos/movie_response_dto.dart';
import '../models/home_screen_response.dart';
import 'http_service.dart';
import 'movie_service.dart';
import 'parser_background_service.dart';

class DatabaseService {
  Future<HomeScreenResponse> getAllHomeScreenData() async {
    final genresFuture = getAllGenresFromDatabase();
    final discoverMoviesFuture = MovieService.getDiscoverMovies();
    final nowPlayingMoviesFuture = MovieService.getNowPlayingMovies();
    final popularMoviesFuture = MovieService.getPopularMovies();
    final topRatedMoviesFuture = MovieService.getTopRatedMovies();
    final upcomingMoviesFuture = MovieService.getUpcomingMovies();

    // Wait for both futures to complete
    final List<dynamic> results = await Future.wait([
      genresFuture,
      discoverMoviesFuture,
      nowPlayingMoviesFuture,
      popularMoviesFuture,
      topRatedMoviesFuture,
      upcomingMoviesFuture,
    ]);

    // Extract results
    final List<GenreDto> genres = results[0];
    final MovieResponseDto discoverMovieResponse = results[1];
    final MovieResponseDto nowPlayingMovieResponse = results[2];
    final MovieResponseDto popularMovieResponse = results[3];
    final MovieResponseDto topRatedMovieResponse = results[4];
    final MovieResponseDto upcomingMovieResponse = results[5];

    return HomeScreenResponse(
      genres: genres,
      discoverMovieResponse: discoverMovieResponse,
      nowPlayingMovieResponse: nowPlayingMovieResponse,
      popularMovieResponse: popularMovieResponse,
      topRatedMovieResponse: topRatedMovieResponse,
      upcomingMovieResponse: upcomingMovieResponse,
    );
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
      return await ParserBackgroundService.parseGenresResponseInBackground(
        response.data,
      );
    } else {
      debugPrint(
          'UrlPath: $kGetAllGenres, Status Code: ${response.statusCode}');
      debugPrint('Reason: ${response.statusMessage}');
      throw Exception(response.statusMessage);
    }
  }
}
