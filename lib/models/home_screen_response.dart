import '../dtos/genre_dto.dart';
import '../dtos/movie_response_dto.dart';

class HomeScreenResponse {
  final List<GenreDto> genres;
  final MovieResponseDto discoverMovieResponse;
  final MovieResponseDto nowPlayingMovieResponse;
  final MovieResponseDto popularMovieResponse;
  final MovieResponseDto topRatedMovieResponse;
  final MovieResponseDto upcomingMovieResponse;

  HomeScreenResponse({
    required this.genres,
    required this.discoverMovieResponse,
    required this.nowPlayingMovieResponse,
    required this.popularMovieResponse,
    required this.topRatedMovieResponse,
    required this.upcomingMovieResponse,
  });
}
