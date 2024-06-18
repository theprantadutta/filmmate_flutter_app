import 'package:flutter/material.dart';

import '../../../models/single_movie_detail_tab.dart';

List<SingleMovieDetailTab> kSingleMovieDetailTabs = [
  SingleMovieDetailTab(
    title: 'Overview',
    iconData: Icons.summarize_outlined,
  ),
  SingleMovieDetailTab(
    title: 'Casts',
    iconData: Icons.groups_2_outlined,
  ),
  SingleMovieDetailTab(
    title: 'Videos',
    iconData: Icons.play_circle_fill_outlined,
  ),
  SingleMovieDetailTab(
    title: 'Top Picks',
    iconData: Icons.recommend_outlined,
  ),
  SingleMovieDetailTab(
    title: 'Alerts',
    iconData: Icons.notifications_outlined,
  ),
  SingleMovieDetailTab(
    title: 'Posters',
    iconData: Icons.movie_creation_outlined,
  ),
];
