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
    final moviesFuture = MovieService.getDiscoverMovies();
    final genresFuture = getAllGenresFromDatabase();

    // Wait for both futures to complete
    final List<dynamic> results =
        await Future.wait([moviesFuture, genresFuture]);

    // Extract results
    final MovieResponseDto discoverMovieResponse = results[0];
    final List<GenreDto> genres = results[1];

    return HomeScreenResponse(
      discoverMovieResponse: discoverMovieResponse,
      genres: genres,
    );
  }

  Future<MovieResponseDto> getSomeMoviesFromDatabase({
    required String urlPath,
    int pageNumber = 1,
  }) async {
    var url = '$kApiUrl/$urlPath?pageNumber=$pageNumber';
    var response = await HttpService.get(url);
    if (response.statusCode == 200) {
      // log(response.body);
      // Use compute to parse the response body in a background isolate
      return await ParserBackgroundService.parseMovieResponseInBackground(
          response.body);
    } else {
      debugPrint('UrlPath: $urlPath, Status Code: ${response.statusCode}');
      debugPrint('Reason: ${response.reasonPhrase}');
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<GenreDto>> getAllGenresFromDatabase() async {
    var url = '$kApiUrl/$kGetAllGenres';
    var response = await HttpService.get(url);
    if (response.statusCode == 200) {
      // log(response.body);
      // Use compute to parse the response body in a background isolate
      return await ParserBackgroundService.parseGenresResponseInBackground(
          response.body);
    } else {
      debugPrint(
          'UrlPath: $kGetAllGenres, Status Code: ${response.statusCode}');
      debugPrint('Reason: ${response.reasonPhrase}');
      throw Exception(response.reasonPhrase);
    }
  }
}
