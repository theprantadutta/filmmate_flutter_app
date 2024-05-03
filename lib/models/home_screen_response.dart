import '../dtos/genre_dto.dart';
import '../dtos/movie_response_dto.dart';

class HomeScreenResponse {
  final MovieResponseDto discoverMovieResponse;
  final List<GenreDto> genres;

  HomeScreenResponse({
    required this.discoverMovieResponse,
    required this.genres,
  });
}
