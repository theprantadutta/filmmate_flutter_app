import '../entities/genre.dart';
import '../entities/movie.dart';

class HomeScreenResponse {
  final List<Genre> genres;
  final List<Movie> discoverMovies;
  final List<Movie> nowPlayings;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;

  HomeScreenResponse({
    required this.genres,
    required this.discoverMovies,
    required this.nowPlayings,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
  });
}
