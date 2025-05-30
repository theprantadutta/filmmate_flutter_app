import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../dtos/genre_dto.dart';

class MoviePosterGenres extends StatelessWidget {
  const MoviePosterGenres({
    super.key,
    required this.genres,
  });

  final List<GenreDto> genres;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: genres.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final genre = genres.toList()[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: kPrimaryColor,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
              ),
              child: Text(
                genre.name,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
