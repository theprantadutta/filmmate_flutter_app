import 'dart:convert';

import '../dtos/genre_dto.dart';
import '../dtos/movie_detail_dto.dart';
import '../dtos/movie_response_dto.dart';

class ParserService {
  // Parse the response body to MovieResponseDto
  static MovieResponseDto parseMovieResponse(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return MovieResponseDto.fromJson(parsed);
  }

  // Parse the response body to GenreDto list
  static List<GenreDto> parseGenresResponse(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return List<GenreDto>.from(parsed.map((json) => GenreDto.fromJson(json)));
  }

  // Parse the response body to MovieDetailDto list
  static MovieDetailDto parseMovieDetailResponse(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return MovieDetailDto.fromJson(parsed);
  }
}
