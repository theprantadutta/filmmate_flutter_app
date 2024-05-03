import 'package:flutter/foundation.dart';

import '../dtos/genre_dto.dart';
import '../dtos/movie_response_dto.dart';
import 'parser_service.dart';

class ParserBackgroundService {
  // This function is executed in a background isolate
  static Future<MovieResponseDto> parseMovieResponseInBackground(
    String responseBody,
  ) async {
    return compute(ParserService.parseMovieResponse, responseBody);
  }

  // This function is executed in a background isolate
  static Future<List<GenreDto>> parseGenresResponseInBackground(
    String responseBody,
  ) async {
    return compute(ParserService.parseGenresResponse, responseBody);
  }
}
