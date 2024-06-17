import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../dtos/genre_dto.dart';
import '../dtos/image_dto.dart';
import '../dtos/movie_detail_dto.dart';
import '../dtos/movie_dto.dart';
import '../entities/cast.dart';
import '../entities/discover_movie.dart';
import '../entities/genre.dart';
import '../entities/images.dart';
import '../entities/movie.dart';
import '../entities/movie_credit.dart';
import '../entities/movie_detail.dart';
import '../entities/now_playing_movie.dart';
import '../entities/popular_movie.dart';
import '../entities/production_company.dart';
import '../entities/production_country.dart';
import '../entities/single_image.dart';
import '../entities/spoken_language.dart';
import '../entities/top_rated_movie.dart';
import '../entities/upcoming_movie.dart';
import '../entities/video.dart';

class IsarService {
  late Future<Isar> db;

  /// Gets Called when we initiate a new Isar Instance
  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [
          CastSchema,
          DiscoverMovieSchema,
          GenreSchema,
          ImagesSchema,
          MovieCreditSchema,
          MovieDetailSchema,
          MovieSchema,
          NowPlayingMovieSchema,
          PopularMovieSchema,
          ProductionCompanySchema,
          ProductionCountrySchema,
          SingleImageSchema,
          SpokenLanguageSchema,
          TopRatedMovieSchema,
          UpcomingMovieSchema,
          VideoSchema,
        ],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<List<Movie>> saveSomeMovies(List<MovieDto> movies) async {
    final isar = await openDB();

    List<Movie> savingMovieList = [];

    for (final movie in movies) {
      // save genres
      List<Genre> genres = [];
      for (final genre in movie.genres) {
        final existingGenre =
            await isar.genres.filter().idEqualTo(genre.id).findFirst();
        if (existingGenre == null) {
          genres.add(
            Genre()
              ..id = genre.id
              ..name = genre.name,
          );
        } else {
          genres.add(existingGenre);
        }
      }

      final existingMovie =
          await isar.movies.filter().idEqualTo(movie.id).findFirst();

      Movie theMovie;
      if (existingMovie == null) {
        theMovie = Movie()
          ..id = movie.id
          ..adult = movie.adult
          ..backdropPath = movie.backdropPath
          ..orderBy = movie.orderBy
          ..posterPath = movie.posterPath
          ..releaseDate = movie.releaseDate
          ..certification = movie.certification
          ..runtime = movie.runtime
          ..voteAverage = movie.voteAverage
          ..title = movie.title;
      } else {
        theMovie = existingMovie;
      }

      await isar.writeTxn(() async {
        await isar.genres.putAll(genres);
        theMovie.genres.addAll(genres);
        await isar.movies.put(theMovie);
        theMovie.genres.save();
      });
      savingMovieList.add(theMovie);
    }

    return savingMovieList;
  }

  Future<MovieDetail> saveTheMovieDetail(MovieDetailDto movie) async {
    final isar = await openDB();

    // save production companies
    List<ProductionCompany> productionCompanies = [];
    for (final productionCompany in movie.productionCompanies) {
      productionCompanies.add(
        ProductionCompany()
          ..id = productionCompany.id
          ..name = productionCompany.name
          ..logoPath = productionCompany.logoPath
          ..originCountry = productionCompany.originCountry,
      );
    }

    // save production countries
    List<ProductionCountry> productionCountries = [];
    for (final productionCountry in movie.productionCountries) {
      productionCountries.add(ProductionCountry()
        ..id = productionCountry.id
        ..name = productionCountry.name);
    }

    // save spoken languages
    List<SpokenLanguage> spokenLanguages = [];
    for (final spokenLanguage in movie.spokenLanguages) {
      spokenLanguages.add(SpokenLanguage()
        ..englishName = spokenLanguage.englishName
        ..name = spokenLanguage.name);
    }

    // save casts
    List<Cast> casts = [];
    for (final cast in movie.casts) {
      casts.add(
        Cast()
          ..id = cast.id
          ..actorId = cast.actorId
          ..adult = cast.adult
          ..castId = cast.castId
          ..character = cast.character
          ..gender = cast.gender
          ..knownForDepartment = cast.knownForDepartment
          ..name = cast.name
          ..popularity = cast.popularity
          ..order = cast.order
          ..profilePath = cast.profilePath,
      );
    }

    // save movieCredit
    final credit = movie.movieCredit;
    final movieCredit = MovieCredit()
      ..id = credit.id
      ..directors = credit.directors
      ..musicBy = credit.musicBy
      ..writers = credit.writers
      ..producers = credit.producers
      ..storyBy = credit.storyBy;

    // save images
    final allImages = movie.images;

    // backdrops
    final backdrops = await processSomeImages(allImages.backdrops);
    final posters = await processSomeImages(allImages.posters);
    final logos = await processSomeImages(allImages.logos);
    final dbImages = Images();

    // save videos
    List<Video> videos = [];
    for (final video in movie.videos) {
      videos.add(
        Video()
          ..id = video.id
          ..key = video.key
          ..name = video.name
          ..official = video.official
          ..publishedAt = video.publishedAt
          ..site = video.site
          ..size = video.size
          ..type = video.type,
      );
    }

    final recommendedMovies = await saveSomeMovies(movie.recommendedMovies);

    final theMovieDetails = MovieDetail()
      ..id = movie.id
      ..budget = movie.budget
      ..homePage = movie.homePage
      ..imdbId = movie.imdbId
      ..originalTitle = movie.originalTitle
      ..overView = movie.overView
      ..revenue = movie.revenue
      ..runtime = movie.runtime
      ..status = movie.status
      ..tagline = movie.tagline
      ..awards = movie.awards
      ..imdbRating = movie.imdbRating
      ..rottenTomatoesScore = movie.rottenTomatoesScore
      ..metaCriticScore = movie.metaCriticScore;

    // Get the actualMovie
    final actualMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (actualMovie == null) {
      if (kDebugMode) {
        print('movie not found: ${movie.toJson()}');
      }
      throw Exception("Actual Movie Not Found");
    }

    await isar.writeTxn(() async {
      await isar.productionCompanys.putAll(productionCompanies);
      theMovieDetails.productionCompanies.addAll(productionCompanies);

      await isar.productionCountrys.putAll(productionCountries);
      theMovieDetails.productionCountries.addAll(productionCountries);

      await isar.spokenLanguages.putAll(spokenLanguages);
      theMovieDetails.spokenLanguages.addAll(spokenLanguages);

      await isar.casts.putAll(casts);
      theMovieDetails.casts.addAll(casts);

      await isar.movieCredits.put(movieCredit);
      theMovieDetails.movieCredit.value = movieCredit;

      dbImages.backdrops.addAll(backdrops);
      dbImages.posters.addAll(posters);
      dbImages.backdrops.addAll(logos);

      await isar.images.put(dbImages);
      theMovieDetails.images.value = dbImages;
      dbImages.backdrops.save();
      dbImages.posters.save();
      dbImages.backdrops.save();
      dbImages.movieDetail.save();

      await isar.videos.putAll(videos);
      theMovieDetails.videos.addAll(videos);

      actualMovie.movieDetail.value = theMovieDetails;
      await isar.movieDetails.put(theMovieDetails);
      await actualMovie.movieDetail.save();

      theMovieDetails.productionCompanies.save();
      theMovieDetails.productionCountries.save();
      theMovieDetails.spokenLanguages.save();
      theMovieDetails.casts.save();
      theMovieDetails.movieCredit.save();

      theMovieDetails.images.save();
      theMovieDetails.videos.save();

      theMovieDetails.recommendedMovies.addAll(recommendedMovies);
      theMovieDetails.recommendedMovies.save();
    });
    return theMovieDetails;
  }

  Future<List<SingleImage>> processSomeImages(List<ImageDto> images) async {
    final isar = await openDB();
    final List<SingleImage> allImages = [];

    for (final image in images) {
      allImages.add(SingleImage()
        ..aspectRatio = image.aspectRatio
        ..filePath = image.filePath
        ..height = image.height
        ..width = image.width);
    }
    await isar.writeTxn(() => isar.singleImages.putAll(allImages));
    return allImages;
  }

  Future<List<Genre>> saveAllGenres(List<GenreDto> genreDtos) async {
    final isar = await IsarService().openDB();
    List<Genre> genres = [];
    List<Genre> genresToBeAdded = [];

    for (final genre in genreDtos) {
      final existingGenre =
          await isar.genres.filter().idEqualTo(genre.id).findFirst();

      if (existingGenre != null) {
        genres.add(existingGenre);
        continue;
      }
      final newGenre = Genre()
        ..id = genre.id
        ..name = genre.name;

      genres.add(newGenre);
      genresToBeAdded.add(newGenre);
    }
    await isar.writeTxn(() => isar.genres.putAll(genresToBeAdded));
    return genres;
  }

  Future<List<Genre>> getAllGenresFromLocalDb() async {
    final isar = await openDB();
    return await isar.genres.where().findAll();
  }

  Future<List<Movie>> getAllGenresByGenreName(Genre genre) async {
    final isar = await openDB();
    final genreWiseMoviesFromDb = await isar.movies
        .filter()
        .genres(
          (q) => q.idEqualTo(genre.id),
        )
        .findAll();
    return genreWiseMoviesFromDb;
  }
}
