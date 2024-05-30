import 'package:filmmate_flutter_app/entities/now_playing_movie.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../constants/urls.dart';
import '../entities/discover_movie.dart';
import '../entities/movie.dart';
import '../entities/popular_movie.dart';
import '../entities/top_rated_movie.dart';
import '../entities/upcoming_movie.dart';
import 'database_service.dart';
import 'isar_service.dart';

class MovieService {
  static Future<List<DiscoverMovie>> getDiscoverMovies() async {
    try {
      // Fetch a list of movies from the database using the specified URL path.
      final fetchedMovies = await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetDiscoverMovies,
      );

      // Open the Isar database.
      final isar = await IsarService().openDB();

      // Save the fetched movies to the Isar database and get the list of saved movies.
      List<Movie> savedMovies =
          await IsarService().saveSomeMovies(fetchedMovies.movies);

      // List to hold movies that will be saved as DiscoverMovie objects in Isar.
      List<DiscoverMovie> newDiscoverMoviesForIsar = [];

      // Iterate over the saved movies to check if they already exist in the DiscoverMovie collection.
      for (var movie in savedMovies) {
        // Check if the movie already exists in the DiscoverMovie collection.
        final existingDiscoverMovie = await isar.discoverMovies
            .filter()
            .movie(
              (q) => q.idEqualTo(movie.id),
            )
            .findFirst();

        // If the movie already exists, skip to the next movie.
        if (existingDiscoverMovie != null) continue;

        // Create a new DiscoverMovie object and set its movie reference.
        final newDiscoverMovie = DiscoverMovie()..movie.value = movie;
        newDiscoverMoviesForIsar.add(newDiscoverMovie);

        // Save the new DiscoverMovie object and its associated movie in a transaction.
        await isar.writeTxn(() async {
          await isar.discoverMovies.put(newDiscoverMovie);
          await newDiscoverMovie.movie.save();
        });
      }

      // Save all new DiscoverMovie objects in a single transaction.
      await isar.writeTxn(() async {
        await isar.discoverMovies.putAll(newDiscoverMoviesForIsar);
      });

      // Return the fetched movies as a MovieResponseDto.
      // return fetchedMovies;
      return newDiscoverMoviesForIsar;
    } catch (e) {
      // If in debug mode, print the error message to the console.
      if (kDebugMode) {
        print(e);
      }

      // Rethrow the exception to be handled by the calling code.
      rethrow;
    }
  }

  static Future<List<NowPlayingMovie>> getNowPlayingMovies() async {
    try {
      final nowPlayingMovies =
          await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetNowPlayingMovies,
      );

      // Open the Isar database.
      final isar = await IsarService().openDB();

      // Save the fetched movies to the Isar database and get the list of saved movies.
      List<Movie> savedMovies =
          await IsarService().saveSomeMovies(nowPlayingMovies.movies);

      // List to hold movies that will be saved as NowPlaying objects in Isar.
      List<NowPlayingMovie> newNowPlayingMoviesForIsar = [];

      // Iterate over the saved movies to check if they already exist in the NowPlaying collection.
      for (var movie in savedMovies) {
        // Check if the movie already exists in the NowPlaying collection.
        final existingNowPlayingMovie = await isar.nowPlayingMovies
            .filter()
            .movie(
              (q) => q.idEqualTo(movie.id),
            )
            .findFirst();

        // If the movie already exists, skip to the next movie.
        if (existingNowPlayingMovie != null) continue;

        // Create a new NowPlayingMovie object and set its movie reference.
        final newNowPlayingMovie = NowPlayingMovie()..movie.value = movie;
        newNowPlayingMoviesForIsar.add(newNowPlayingMovie);

        // Save the new NowPlayingMovie object and its associated movie in a transaction.
        await isar.writeTxn(() async {
          await isar.nowPlayingMovies.put(newNowPlayingMovie);
          await newNowPlayingMovie.movie.save();
        });
      }

      // Save all new NowPlayingMovie objects in a single transaction.
      await isar.writeTxn(() async {
        await isar.nowPlayingMovies.putAll(newNowPlayingMoviesForIsar);
      });

      // Return the fetched movies as a MovieResponseDto.
      // return nowPlayingMovies;
      return newNowPlayingMoviesForIsar;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  static Future<List<PopularMovie>> getPopularMovies() async {
    try {
      final popularMovies = await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetPopularMovies,
      );

      // Open the Isar database.
      final isar = await IsarService().openDB();

      // Save the fetched movies to the Isar database and get the list of saved movies.
      List<Movie> savedMovies =
          await IsarService().saveSomeMovies(popularMovies.movies);

      // List to hold movies that will be saved as Popular objects in Isar.
      List<PopularMovie> newPopularMoviesForIsar = [];

      // Iterate over the saved movies to check if they already exist in the PopularMovie collection.
      for (var movie in savedMovies) {
        // Check if the movie already exists in the PopularMovie collection.
        final existingPopularMovie = await isar.popularMovies
            .filter()
            .movie(
              (q) => q.idEqualTo(movie.id),
            )
            .findFirst();

        // If the movie already exists, skip to the next movie.
        if (existingPopularMovie != null) continue;

        // Create a new PopularMovie object and set its movie reference.
        final newPopularMovie = PopularMovie()..movie.value = movie;
        newPopularMoviesForIsar.add(newPopularMovie);

        // Save the new PopularMovie object and its associated movie in a transaction.
        await isar.writeTxn(() async {
          await isar.popularMovies.put(newPopularMovie);
          await newPopularMovie.movie.save();
        });
      }

      // Save all new PopularMovie objects in a single transaction.
      await isar.writeTxn(() async {
        await isar.popularMovies.putAll(newPopularMoviesForIsar);
      });

      return newPopularMoviesForIsar;
      // return popularMovies;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  static Future<List<TopRatedMovie>> getTopRatedMovies() async {
    try {
      final topRatedMovies = await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetTopRatedMovies,
      );

      // Open the Isar database.
      final isar = await IsarService().openDB();

      // Save the fetched movies to the Isar database and get the list of saved movies.
      List<Movie> savedMovies =
          await IsarService().saveSomeMovies(topRatedMovies.movies);

      // List to hold movies that will be saved as TopRated objects in Isar.
      List<TopRatedMovie> newTopRatedMoviesForIsar = [];

      // Iterate over the saved movies to check if they already exist in the TopRatedMovie collection.
      for (var movie in savedMovies) {
        // Check if the movie already exists in the TopRatedMovie collection.
        final existingTopRatedMovie = await isar.topRatedMovies
            .filter()
            .movie(
              (q) => q.idEqualTo(movie.id),
            )
            .findFirst();

        // If the movie already exists, skip to the next movie.
        if (existingTopRatedMovie != null) continue;

        // Create a new TopRatedMovie object and set its movie reference.
        final newTopRatedMovie = TopRatedMovie()..movie.value = movie;
        newTopRatedMoviesForIsar.add(newTopRatedMovie);

        // Save the new TopRatedMovie object and its associated movie in a transaction.
        await isar.writeTxn(() async {
          await isar.topRatedMovies.put(newTopRatedMovie);
          await newTopRatedMovie.movie.save();
        });
      }

      // Save all new TopRatedMovie objects in a single transaction.
      await isar.writeTxn(() async {
        await isar.topRatedMovies.putAll(newTopRatedMoviesForIsar);
      });

      return newTopRatedMoviesForIsar;
      // return topRatedMovies;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  static Future<List<UpcomingMovie>> getUpcomingMovies() async {
    try {
      final upcomingMovies = await DatabaseService().getSomeMoviesFromDatabase(
        urlPath: kGetUpcomingMovies,
      );

      // Open the Isar database.
      final isar = await IsarService().openDB();

      // Save the fetched movies to the Isar database and get the list of saved movies.
      List<Movie> savedMovies =
          await IsarService().saveSomeMovies(upcomingMovies.movies);

      // List to hold movies that will be saved as Upcoming objects in Isar.
      List<UpcomingMovie> newUpcomingMoviesForIsar = [];

      // Iterate over the saved movies to check if they already exist in the UpcomingMovie collection.
      for (var movie in savedMovies) {
        // Check if the movie already exists in the UpcomingMovie collection.
        final existingUpcomingMovie = await isar.upcomingMovies
            .filter()
            .movie(
              (q) => q.idEqualTo(movie.id),
            )
            .findFirst();

        // If the movie already exists, skip to the next movie.
        if (existingUpcomingMovie != null) continue;

        // Create a new UpcomingMovie object and set its movie reference.
        final newUpcomingMovie = UpcomingMovie()..movie.value = movie;
        newUpcomingMoviesForIsar.add(newUpcomingMovie);

        // Save the new UpcomingMovie object and its associated movie in a transaction.
        await isar.writeTxn(() async {
          await isar.upcomingMovies.put(newUpcomingMovie);
          await newUpcomingMovie.movie.save();
        });
      }

      // Save all new UpcomingMovie objects in a single transaction.
      await isar.writeTxn(() async {
        await isar.upcomingMovies.putAll(newUpcomingMoviesForIsar);
      });

      return newUpcomingMoviesForIsar;
      // return upcomingMovies;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
