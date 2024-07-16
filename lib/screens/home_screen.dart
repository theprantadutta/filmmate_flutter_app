import 'package:filmmate_flutter_app/models/home_screen_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/layouts/main_layout.dart';
import '../../enums/movie_type.dart';
import '../../services/database_service.dart';
import '../components/common/cached_future_handler.dart';
import '../components/home/genres_section.dart';
import '../components/home/home_header.dart';
import '../components/home/movie_section.dart';
import '../components/home/movie_section/movie_section_top_bar.dart';

class HomeScreen extends StatelessWidget {
  static const kRouteName = '/';

  const HomeScreen({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    // Exit the app
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final defaultHeight = MediaQuery.sizeOf(context).height * 0.87;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _onWillPop(context);
      },
      child: MainLayout(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const HomeHeader(),
                SizedBox(
                  height: defaultHeight,
                  child: CachedFutureHandler<HomeScreenResponse, Exception>(
                    id: 'home-screen-movies',
                    defaultHeight: defaultHeight,
                    future: DatabaseService().getAllHomeScreenData,
                    builder: (context, data) {
                      final discoverMovies = data.discoverMovies;
                      final nowPlayingMovies = data.nowPlayings;
                      final popularMovies = data.popularMovies;
                      final topRatedMovies = data.topRatedMovies;
                      final upcomingMovies = data.upcomingMovies;
                      final genres = data.genres;

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            const MovieSectionTopBar(
                              title: 'Genres',
                              movieType: MovieType.genreWise,
                            ),
                            GenresSection(
                              genres: genres,
                            ),
                            const SizedBox(height: 10),
                            MovieSection(
                              title: 'Discover Movies',
                              movies: discoverMovies,
                              movieType: MovieType.discover,
                            ),
                            const SizedBox(height: 10),
                            MovieSection(
                              title: 'Popular Movies',
                              movies: popularMovies,
                              movieType: MovieType.popular,
                            ),
                            const SizedBox(height: 10),
                            MovieSection(
                              title: 'Now Playing Movies',
                              movies: nowPlayingMovies,
                              movieType: MovieType.nowPlaying,
                            ),
                            const SizedBox(height: 10),
                            MovieSection(
                              title: 'Top Rated Movies',
                              movies: topRatedMovies,
                              movieType: MovieType.topRated,
                            ),
                            const SizedBox(height: 10),
                            MovieSection(
                              title: 'Upcoming Movies',
                              movies: upcomingMovies,
                              movieType: MovieType.upcoming,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
