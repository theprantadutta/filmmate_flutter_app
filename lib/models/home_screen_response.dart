import '../dtos/genre_dto.dart';
import '../dtos/movie_response_dto.dart';

class HomeScreenResponse {
  final List<GenreDto> genres;
  final MovieResponseDto discoverMovies;
  final MovieResponseDto nowPlayings;
  final MovieResponseDto popularMovies;
  final MovieResponseDto topRatedMovies;
  final MovieResponseDto upcomingMovies;

  HomeScreenResponse({
    required this.genres,
    required this.discoverMovies,
    required this.nowPlayings,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
  });
}
