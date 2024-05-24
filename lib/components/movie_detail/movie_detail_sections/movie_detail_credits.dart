import 'package:flutter/material.dart';

import '../../../dtos/movie_detail_dto.dart';

class MovieDetailCredits extends StatelessWidget {
  const MovieDetailCredits({
    super.key,
    required this.movieDetail,
  });

  final MovieDetailDto movieDetail;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Credits'),
    );
  }
}
