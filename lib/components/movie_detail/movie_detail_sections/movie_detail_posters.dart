import 'package:flutter/material.dart';

import '../../../dtos/movie_detail_dto.dart';

class MovieDetailPosters extends StatelessWidget {
  const MovieDetailPosters({
    super.key,
    required this.movieDetail,
  });

  final MovieDetailDto movieDetail;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Posters'),
    );
  }
}
