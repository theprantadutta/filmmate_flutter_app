import 'dart:async';

import 'package:filmmate_flutter_app/entities/discover_movie.dart';
import 'package:filmmate_flutter_app/entities/genre.dart';
import 'package:filmmate_flutter_app/entities/movie.dart';
import 'package:filmmate_flutter_app/entities/now_playing_movie.dart';
import 'package:filmmate_flutter_app/entities/popular_movie.dart';
import 'package:filmmate_flutter_app/entities/top_rated_movie.dart';
import 'package:filmmate_flutter_app/entities/upcoming_movie.dart';
import 'package:filmmate_flutter_app/services/isar_service.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../constants/urls.dart';
import '../dtos/movie_detail_dto.dart';
import '../dtos/movie_response_dto.dart';
import '../models/home_screen_response.dart';
import 'http_service.dart';
import 'movie_service.dart';
import 'parser_background_service.dart';

class DatabaseService {
  Future<MovieDetailDto> getMovieDetailFromDatabase(int movieId) async {
    var url = '$kApiUrl/$kGetMovieDetail?movieId=$movieId';
    var response = await HttpService.get(url);
    if (response.statusCode == 200) {
      // Use compute to parse the response body in a background isolate
      return await ParserBackgroundService.parseMovieDetailResponseInBackground(
        response.data,
      );
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
          seconds: 3,
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
    // final genresFuture = getAllGenresFromDatabase();
    final discoverMoviesFuture = MovieService.getDiscoverMovies();
    final nowPlayingMoviesFuture = MovieService.getNowPlayingMovies();
    final popularMoviesFuture = MovieService.getPopularMovies();
    final topRatedMoviesFuture = MovieService.getTopRatedMovies();
    final upcomingMoviesFuture = MovieService.getUpcomingMovies();

    // Wait for both futures to complete
    await Future.wait([
      // genresFuture,
      discoverMoviesFuture,
      nowPlayingMoviesFuture,
      popularMoviesFuture,
      topRatedMoviesFuture,
      upcomingMoviesFuture,
    ]);
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

  // Future<List<GenreDto>> getAllGenresFromDatabase() async {
  //   var url = '$kApiUrl/$kGetAllGenres';
  //   var response = await HttpService.get(url);
  //   if (response.statusCode == 200) {
  //     // log(response.body);
  //     // Use compute to parse the response body in a background isolate
  //     return await ParserBackgroundService.parseGenresResponseInBackground(
  //       response.data,
  //     );
  //   } else {
  //     debugPrint(
  //         'UrlPath: $kGetAllGenres, Status Code: ${response.statusCode}');
  //     debugPrint('Reason: ${response.statusMessage}');
  //     throw Exception(response.statusMessage);
  //   }
  // }

  Future<List<Genre>> getAllGenresFromDatabase() async {
    final isar = await IsarService().openDB();
    return await isar.genres.where().findAll();
  }
}
