import 'package:flutter/material.dart';

import '../../../entities/genre.dart';

class MoviePosterGenres extends StatelessWidget {
  const MoviePosterGenres({
    super.key,
    required this.genres,
  });

  final List<Genre> genres;

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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
              ),
              child: Text(genre.name),
            ),
          );
        },
      ),
    );
  }
}
