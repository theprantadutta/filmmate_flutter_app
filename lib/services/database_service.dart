import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../constants/urls.dart';
import '../dtos/movie_response_dto.dart';
import 'http_service.dart';

class DatabaseService {
  // Parse the response body to MovieResponseDto
  MovieResponseDto parseMovieResponse(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return MovieResponseDto.fromJson(parsed);
  }

  // This function is executed in a background isolate
  Future<MovieResponseDto> parseMovieResponseInBackground(
    String responseBody,
  ) async {
    return compute(parseMovieResponse, responseBody);
  }

  Future<MovieResponseDto> getSomeMoviesFromDatabase({
    required String urlPath,
    int pageNumber = 1,
  }) async {
    var url = '$kApiUrl/$urlPath?pageNumber=$pageNumber';
    var response = await HttpService.get(url);
    if (response.statusCode == 200) {
      log(response.body);
      // Use compute to parse the response body in a background isolate
      return await parseMovieResponseInBackground(response.body);
    } else {
      debugPrint('UrlPath: $urlPath, Status Code: ${response.statusCode}');
      debugPrint('Reason: ${response.reasonPhrase}');
      throw Exception(response.reasonPhrase);
    }
  }
}
