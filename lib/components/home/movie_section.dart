import 'package:flutter/material.dart';

import '../../dtos/movie_dto.dart';
import 'movie_section/movie_section_top_bar.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<MovieDto> movies;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    // final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        MovieSectionTopBar(
          title: title,
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.28,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.25,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // child: Text(movie.title),
                  ),
                  // Text(data)
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
