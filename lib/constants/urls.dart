import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final kApiProdUrl = dotenv.env['PROD_API_URL'];
final kApiDevUrl = dotenv.env['DEV_API_URL'];
final kApiUrl = kDebugMode ? kApiDevUrl : kApiProdUrl;
// const kApiUrl = kApiProdUrl;

const kGetAllGenres = 'Movie/GetAllGenres';
const kGetAllMoviesByGenre = 'Movie/GetGenreWiseMovies';

const kGetDiscoverMovies = 'Movie/GetDiscoverMovies';
const kGetGenreWiseMovies = 'Movie/GetGenreWiseMovies';
const kGetNowPlayingMovies = 'Movie/GetNowPlayingMovies';
const kGetPopularMovies = 'Movie/GetPopularMovies';
const kGetTopRatedMovies = 'Movie/GetTopRatedMovies';
const kGetUpcomingMovies = 'Movie/GetUpcomingMovies';

const kGetMovieDetail = 'Movie/GetMovieDetail';
const kGetSearchMovies = 'Movie/SearchMovies';
