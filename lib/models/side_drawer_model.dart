import 'package:flutter/material.dart';

import '../enums/movie_type.dart';

class SideDrawerModel {
  final String name;
  final IconData iconData;
  final MovieType movieType;

  SideDrawerModel({
    required this.name,
    required this.iconData,
    required this.movieType,
  });
}
