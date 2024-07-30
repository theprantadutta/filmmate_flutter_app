import 'package:flutter/material.dart';

import '../../dtos/movie_detail_dto.dart';
import 'movie_detail_sections/movie_detail_casts.dart';
import 'movie_detail_sections/movie_detail_notification.dart';
import 'movie_detail_sections/movie_detail_overview/movie_detail_overview.dart';
import 'movie_detail_sections/movie_detail_posters.dart';
import 'movie_detail_sections/movie_detail_recommendations.dart';
import 'movie_detail_sections/movie_detail_videos.dart';

class MovieDetailTabBar extends StatelessWidget {
  final MovieDetailDto movieDetail;

  const MovieDetailTabBar({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
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
          recommendedMovies: movieDetail.recommendedMovies.toList(),
        ),
        MovieDetailNotification(
          movieId: movieDetail.id,
        ),
        MovieDetailPosters(
          posters: movieDetail.images.posters,
        ),
      ],
    );
  }
}

class MovieDetailTabBarSkeletor extends StatelessWidget {
  const MovieDetailTabBarSkeletor({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        MovieDetailOverviewSkeletor(),
        MovieDetailOverviewSkeletor(),
        MovieDetailOverviewSkeletor(),
        MovieDetailOverviewSkeletor(),
        MovieDetailOverviewSkeletor(),
        MovieDetailOverviewSkeletor(),
      ],
    );
  }
}
