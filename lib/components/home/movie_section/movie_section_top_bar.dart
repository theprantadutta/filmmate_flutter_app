import 'package:flutter/material.dart';

import '../../../enums/movie_type.dart';
import '../../../screen_arguments/movie_section_screen_arguments.dart';
import '../../../screens/movie_section_screen.dart';

class MovieSectionTopBar extends StatelessWidget {
  final String title;
  final MovieType movieType;

  const MovieSectionTopBar({
    super.key,
    required this.title,
    required this.movieType,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              MovieSectionScreen.kRouteName,
              arguments: MovieSectionScreenArguments(
                movieType: movieType,
                title: title,
              ),
            ),
            child: Text(
              'See All',
              style: TextStyle(
                fontSize: 16,
                color:
                    isDarkTheme ? Colors.grey.shade500 : Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
