import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../constants/urls.dart';
import '../dtos/movie_response_dto.dart';
import '../entities/discover_movie.dart';
import '../entities/genre.dart';
import '../entities/movie.dart';
import '../entities/movie_detail.dart';
import '../entities/now_playing_movie.dart';
import '../entities/popular_movie.dart';
import '../entities/top_rated_movie.dart';
import '../entities/upcoming_movie.dart';
import '../models/home_screen_response.dart';
import '../services/isar_service.dart';
import 'http_service.dart';
import 'movie_service.dart';
import 'parser_background_service.dart';

class DatabaseService {
  Future<MovieDetail> getMovieDetailFromDatabase(int movieId) async {
    final isar = await IsarService().openDB();
    final movieDetail =
        await isar.movieDetails.filter().idEqualTo(movieId).findFirst();

    if (movieDetail != null) {
      return movieDetail;
    }

    var url = '$kApiUrl/$kGetMovieDetail?movieId=$movieId';
    var response = await HttpService.get(url);
    if (response.statusCode == 200) {
      // Use compute to parse the response body in a background isolate
      final movieDetailDto =
          await ParserBackgroundService.parseMovieDetailResponseInBackground(
        response.data,
      );
      return await IsarService().saveTheMovieDetail(movieDetailDto);
    } else {
      debugPrint('UrlPath: $url, Status Code: ${response.statusCode}');
      debugPrint('Reason: ${response.statusMessage}');
      throw Exception(response.statusMessage);
    }
  }

  Future<HomeScreenResponse> getAllHomeScreenData() async {
    final isar = await IsarService().openDB();

    final existingMovieCount = await isar.movies.count();

    if (existingMovieCount > 0) {
      Timer(
        const Duration(
          seconds: 10,
        ),
        () async {
          debugPrint('##########################');
          debugPrint('Fetching Latest Movies...');
          await fetchLatestMovieData();
          debugPrint('Fetched Latest Movies Successfully');
          debugPrint('##########################');
        },
      );
      return getHomeScreenResponseData();
    }
    await fetchLatestMovieData();
    return getHomeScreenResponseData();
  }

  Future<void> fetchLatestMovieData() async {
    final genresFuture = getAllGenresFromDatabase();
    final discoverMoviesFuture = MovieService.getDiscoverMovies();
    final nowPlayingMoviesFuture = MovieService.getNowPlayingMovies();
    final popularMoviesFuture = MovieService.getPopularMovies();
    final topRatedMoviesFuture = MovieService.getTopRatedMovies();
    final upcomingMoviesFuture = MovieService.getUpcomingMovies();

    try {
      // Wait for both futures to complete
      await Future.wait([
        genresFuture,
        discoverMoviesFuture,
        nowPlayingMoviesFuture,
        popularMoviesFuture,
        topRatedMoviesFuture,
        upcomingMoviesFuture,
      ]);
    } catch (e) {
      if (kDebugMode) {
        print('Something Went Wrong When Fetching all Movies Future');
        print(e);
      }
    }
  }

  Future<HomeScreenResponse> getHomeScreenResponseData() async {
    final isar = await IsarService().openDB();

    final genres = await isar.genres.where().findAll();

    final discoverMoviesFromIsar =
        await isar.discoverMovies.where().limit(10).findAll();

    // Extract the linked Movie objects from each DiscoverMovie object.
    List<Movie> discoverMovies = [];
    for (var discoverMovie in discoverMoviesFromIsar) {
      await discoverMovie.movie.load(); // Ensure the movie link is loaded.
      if (discoverMovie.movie.value != null) {
        discoverMovies.add(discoverMovie.movie.value!);
      }
    }

    final nowPlayingMoviesFromIsar =
        await isar.nowPlayingMovies.where().limit(10).findAll();

    // Extract the linked Movie objects from each NowPlayingMovie object.
    List<Movie> nowPlayingMovies = [];
    for (var nowPlayingMovie in nowPlayingMoviesFromIsar) {
      await nowPlayingMovie.movie.load(); // Ensure the movie link is loaded.
      if (nowPlayingMovie.movie.value != null) {
        nowPlayingMovies.add(nowPlayingMovie.movie.value!);
      }
    }

    final popularMoviesFromIsar =
        await isar.popularMovies.where().limit(10).findAll();

    // Extract the linked Movie objects from each PopularMovie object.
    List<Movie> popularMovies = [];
    for (var popularMovie in popularMoviesFromIsar) {
      await popularMovie.movie.load(); // Ensure the movie link is loaded.
      if (popularMovie.movie.value != null) {
        popularMovies.add(popularMovie.movie.value!);
      }
    }

    final topRatedMoviesFromIsar =
        await isar.topRatedMovies.where().limit(10).findAll();

    // Extract the linked Movie objects from each TopRated object.
    List<Movie> topRatedMovies = [];
    for (var topRatedMovie in topRatedMoviesFromIsar) {
      await topRatedMovie.movie.load(); // Ensure the movie link is loaded.
      if (topRatedMovie.movie.value != null) {
        topRatedMovies.add(topRatedMovie.movie.value!);
      }
    }

    final upcomingMoviesFromIsar =
        await isar.upcomingMovies.where().limit(10).findAll();

    // Extract the linked Movie objects from each Upcoming object.
    List<Movie> upcomingMovies = [];
    for (var upcomingMovie in upcomingMoviesFromIsar) {
      await upcomingMovie.movie.load(); // Ensure the movie link is loaded.
      if (upcomingMovie.movie.value != null) {
        upcomingMovies.add(upcomingMovie.movie.value!);
      }
    }

    discoverMovies.sort((a, b) => a.orderBy - b.orderBy);
    nowPlayingMovies.sort((a, b) => a.orderBy - b.orderBy);
    popularMovies.sort((a, b) => a.orderBy - b.orderBy);
    topRatedMovies.sort((a, b) => a.orderBy - b.orderBy);
    upcomingMovies.sort((a, b) => a.orderBy - b.orderBy);

    return HomeScreenResponse(
      genres: genres,
      discoverMovies: discoverMovies,
      nowPlayings: nowPlayingMovies,
      popularMovies: popularMovies,
      topRatedMovies: topRatedMovies,
      upcomingMovies: upcomingMovies,
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

  Future<List<Genre>> getAllGenresFromDatabase() async {
    final isar = await IsarService().openDB();
    final existingGenreCount = await isar.genres.count();

    if (existingGenreCount > 0) {
      Timer(
        const Duration(
          seconds: 20,
        ),
        () async {
          try {
            debugPrint('##########################');
            debugPrint('Fetching Latest Genres...');
            await fetchAllGenresFromDatabase();
            debugPrint('Fetched Latest Genres Successfully');
            debugPrint('##########################');
          } catch (e) {
            if (kDebugMode) {
              print('Something Went Wrong When Fetching Genres');
              print(e);
            }
          }
        },
      );
      return IsarService().getAllGenresFromLocalDb();
    }
    return fetchAllGenresFromDatabase();
  }

  Future<List<Genre>> fetchAllGenresFromDatabase() async {
    var url = '$kApiUrl/$kGetAllGenres';
    var response = await HttpService.get(url);
    if (response.statusCode == 200) {
      // log(response.body);
      // Use compute to parse the response body in a background isolate
      final allDbGenres =
          await ParserBackgroundService.parseGenresResponseInBackground(
        response.data,
      );
      return await IsarService().saveAllGenres(allDbGenres);
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
