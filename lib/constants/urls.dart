import 'package:flutter/foundation.dart';

const kApiProdUrl = 'https://funny-sara-ann-pranta-85b659af.koyeb.app/api/v1.0';
const kApiDevUrl = 'http://192.168.0.106:5291/api/v1.0';
const kApiUrl = kDebugMode ? kApiDevUrl : kApiProdUrl;
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
