import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../enums/movie_type.dart';
import '../../models/side_drawer_model.dart';
import '../../screen_arguments/genre_screen_arguments.dart';
import '../../screen_arguments/movie_section_screen_arguments.dart';
import '../../screens/genre_screen.dart';
import '../../screens/movie_section_screen.dart';

class SidebarSingleDrawerMenu extends StatelessWidget {
  final SideDrawerModel drawer;
  final int index;

  const SidebarSingleDrawerMenu({
    super.key,
    required this.drawer,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: min(index, 5) * 200),
      child: ListTile(
        splashColor: kPrimaryColor.withOpacity(0.2),
        leading: Icon(drawer.iconData),
        minTileHeight: MediaQuery.sizeOf(context).height * 0.065,
        title: Text(
          drawer.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        // onTap: () => Navigator.pushNamed(
        //   context,
        //   MovieSectionScreen.kRouteName,
        //   arguments: MovieSectionScreenArguments(
        //     movieType: drawer.movieType,
        //     title: drawer.name,
        //   ),
        // ),
        onTap: () {
          if (drawer.movieType == MovieType.genreWise) {
            Navigator.pushNamed(
              context,
              GenreScreen.kRouteName,
              arguments: GenreScreenArguments(),
            );
            return;
          }
          Navigator.pushNamed(
            context,
            MovieSectionScreen.kRouteName,
            arguments: MovieSectionScreenArguments(
              movieType: drawer.movieType,
              title: drawer.name,
            ),
          );
        },
      ),
    );
  }
}
