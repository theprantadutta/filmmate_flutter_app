import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/common/cached_future_handler.dart';
import '../components/movie_detail/movie_detail_sections/movie_detail_casts.dart';
import '../components/movie_detail/movie_detail_sections/movie_detail_overview/movie_detail_overview.dart';
import '../components/movie_detail/movie_detail_sections/movie_detail_posters.dart';
import '../components/movie_detail/movie_detail_sections/movie_detail_recommendations.dart';
import '../components/movie_detail/movie_detail_sections/movie_detail_videos.dart';
import '../components/movie_detail/movie_detail_stack_on_poster.dart';
import '../entities/movie_detail.dart';
import '../screen_arguments/movie_detail_screen_arguments.dart';
import '../services/database_service.dart';
import '../sliver_delegates/sliver_app_bar_delegate.dart';
import '../sliver_delegates/sliver_tab_bar_delegate.dart';

List<SingleMovieDetailTab> singleMovieDetailTabs = [
  SingleMovieDetailTab(title: 'Overview', iconData: Icons.summarize_outlined),
  SingleMovieDetailTab(title: 'Casts', iconData: Icons.groups_2_outlined),
  SingleMovieDetailTab(
      title: 'Videos', iconData: Icons.play_circle_fill_outlined),
  SingleMovieDetailTab(title: 'Top Picks', iconData: Icons.recommend_outlined),
  SingleMovieDetailTab(
      title: 'Posters', iconData: Icons.movie_creation_outlined),
];

class SingleMovieDetailTab {
  final String title;
  final IconData iconData;

  SingleMovieDetailTab({required this.title, required this.iconData});
}

class MovieDetailScreen extends StatelessWidget {
  static const kRouteName = '/movie-detail';
  const MovieDetailScreen({super.key});

  List<Tab> generateTabs(double height) {
    List<Tab> tabs = [];
    for (final singleTab in singleMovieDetailTabs) {
      tabs.add(
        Tab(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(singleTab.iconData),
              Text(
                singleTab.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as MovieDetailScreenArguments;
    final movie = args.movie;
    return Scaffold(
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: SafeArea(
          top: false,
          child: DefaultTabController(
            length: singleMovieDetailTabs.length,
            child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  SliverPersistentHeader(
                    delegate: SliverAppBarDelegate(
                      minHeight: MediaQuery.of(context).size.height * 0.3,
                      maxHeight: MediaQuery.of(context).size.height * 0.6,
                      child: MovieDetailStackOnPoster(
                        tagName: args.tagName,
                        movie: movie,
                      ),
                    ),
                    pinned: true,
                  ),
                  SliverPersistentHeader(
                    delegate: SliverTabBarDelegate(
                      TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        tabs: generateTabs(
                          MediaQuery.sizeOf(context).height * 0.08,
                        ),
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: CachedFutureHandler<MovieDetail, Exception>(
                id: 'movie-detail-${movie.id}',
                future: () =>
                    DatabaseService().getMovieDetailFromDatabase(movie.id),
                builder: (context, data) {
                  final movieDetail = data;
                  return TabBarView(
                    children: [
                      MovieDetailOverview(
                        movieDetail: movieDetail,
                      ),
                      MovieDetailCasts(
                        casts: movieDetail.casts.toList(),
                      ),
                      MovieDetailVideos(
                        videos: movieDetail.videos.toList(),
                      ),
                      MovieDetailRecommendations(
                        recommendedMovies:
                            movieDetail.recommendedMovies.toList(),
                      ),
                      MovieDetailPosters(
                        posters: movieDetail.images.value != null
                            ? movieDetail.images.value!.posters.toList()
                            : [],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
