import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../models/side_drawer_model.dart';
import '../../screen_arguments/movie_section_screen_arguments.dart';
import '../../screens/movie_section_screen.dart';

class SidebarSingleDrawerMenu extends StatelessWidget {
  final SideDrawerModel drawer;

  const SidebarSingleDrawerMenu({
    super.key,
    required this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
      onTap: () => Navigator.pushNamed(
        context,
        MovieSectionScreen.kRouteName,
        arguments: MovieSectionScreenArguments(
          movieType: drawer.movieType,
          title: drawer.name,
        ),
      ),
    );
  }
}
