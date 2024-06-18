import 'package:flutter/material.dart';

import '../../enums/movie_type.dart';
import '../../models/side_drawer_model.dart';

List<SideDrawerModel> kDrawerList = [
  SideDrawerModel(
    name: 'Discover Movies',
    iconData: Icons.travel_explore_outlined,
    movieType: MovieType.discover,
  ),
  SideDrawerModel(
    name: 'Popular Movies',
    iconData: Icons.star_rate_outlined,
    movieType: MovieType.popular,
  ),
  SideDrawerModel(
    name: 'Now Playing Movies',
    iconData: Icons.smart_display_outlined,
    movieType: MovieType.nowPlaying,
  ),
  SideDrawerModel(
    name: 'Top Rated Movies',
    iconData: Icons.verified_outlined,
    movieType: MovieType.topRated,
  ),
  SideDrawerModel(
    name: 'Upcoming Movies',
    iconData: Icons.upcoming_outlined,
    movieType: MovieType.upcoming,
  ),
  SideDrawerModel(
    name: 'Movies By Genre',
    iconData: Icons.difference_outlined,
    movieType: MovieType.genreWise,
  ),
];
