import 'package:flutter/material.dart';

import '../../components/home/movie_section/movie_section_top_bar.dart';
import '../../dtos/genre_dto.dart';
import '../common/custom_outlined_button.dart';

class CategoriesSection extends StatelessWidget {
  final List<GenreDto> genres;

  const CategoriesSection({
    super.key,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        children: [
          const MovieSectionTopBar(title: 'Categories'),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: genres.length,
              itemBuilder: (context, index) {
                final genre = genres[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CustomOutlinedButton(title: genre.name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
