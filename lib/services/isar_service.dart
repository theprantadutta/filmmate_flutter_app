import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

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
import '../entities/production_company.dart';
import '../entities/production_country.dart';
import '../entities/single_image.dart';
import '../entities/spoken_language.dart';
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
        genres.add(Genre()
          ..id = genre.id
          ..name = genre.name);
      }
      await isar.genres.putAll(genres);

      final theMovie = Movie()
        ..adult = movie.adult
        ..backdropPath = movie.backdropPath
        ..orderBy = movie.orderBy
        ..posterPath = movie.posterPath
        ..releaseDate = movie.releaseDate
        ..title = movie.title;

      theMovie.genres.addAll(genres);

      await isar.writeTxn(() => isar.movies.put(theMovie));
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
    await isar.productionCompanys.putAll(productionCompanies);

    // save production countries
    List<ProductionCountry> productionCountries = [];
    for (final productionCountry in movie.productionCountries) {
      productionCountries.add(ProductionCountry()
        ..id = productionCountry.id
        ..name = productionCountry.name);
    }
    await isar.productionCountrys.putAll(productionCountries);

    // save spoken languages
    List<SpokenLanguage> spokenLanguages = [];
    for (final spokenLanguage in movie.spokenLanguages) {
      spokenLanguages.add(SpokenLanguage()
        ..englishName = spokenLanguage.englishName
        ..name = spokenLanguage.name);
    }
    await isar.spokenLanguages.putAll(spokenLanguages);

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
    await isar.casts.putAll(casts);

    // save movieCredit
    final credit = movie.movieCredit;
    final movieCredit = MovieCredit()
      ..id = credit.id
      ..directors = credit.directors
      ..musicBy = credit.musicBy
      ..writers = credit.writers
      ..producers = credit.producers
      ..storyBy = credit.storyBy;

    await isar.movieCredits.put(movieCredit);

    // save images
    final allImages = movie.images;

    // backdrops
    final backdrops = await processSomeImages(allImages.backdrops);
    final posters = await processSomeImages(allImages.posters);
    final logos = await processSomeImages(allImages.logos);
    final dbImages = Images();
    dbImages.backdrops.addAll(backdrops);
    dbImages.posters.addAll(posters);
    dbImages.backdrops.addAll(logos);

    await isar.images.put(dbImages);

    // save videos
    List<Video> videos = [];
    for (final video in movie.videos) {
      videos.add(Video()
        ..id = video.id
        ..key = video.key
        ..name = video.name
        ..official = video.official
        ..publishedAt = video.publishedAt
        ..site = video.site
        ..size = video.size
        ..type = video.type);
    }
    await isar.videos.putAll(videos);

    final theMovie = MovieDetail()
      ..budget = movie.budget
      ..homePage = movie.homePage
      ..imdbId = movie.imdbId
      ..originalTitle = movie.originalTitle
      ..overView = movie.overView
      ..revenue = movie.revenue
      ..runtime = movie.runtime
      ..status = movie.status
      ..tagline = movie.tagline;

    theMovie.productionCompanies.addAll(productionCompanies);
    theMovie.productionCountries.addAll(productionCountries);
    theMovie.spokenLanguages.addAll(spokenLanguages);
    theMovie.casts.addAll(casts);
    theMovie.movieCredit.value = movieCredit;
    theMovie.images.value = dbImages;
    theMovie.videos.addAll(videos);

    await isar.writeTxn(() => isar.movieDetails.put(theMovie));
    return theMovie;
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
}
