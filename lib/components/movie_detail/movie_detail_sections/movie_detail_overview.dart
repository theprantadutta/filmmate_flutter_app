import 'package:filmmate_flutter_app/util/functions.dart';
import 'package:flutter/material.dart';

import '../../../dtos/movie_detail_dto.dart';
import '../movie_detail_another_section.dart';
import '../movie_detail_section.dart';

class MovieDetailOverview extends StatelessWidget {
  const MovieDetailOverview({
    super.key,
    required this.movieDetail,
  });

  final MovieDetailDto movieDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieDetailAnotherSection(
            title: 'Status',
            value: movieDetail.status,
          ),
          MovieDetailAnotherSection(
            title: 'Release Date',
            value: movieDetail.releaseDate ?? 'N/A',
          ),
          MovieDetailSection(
            title: 'Tagline',
            value: movieDetail.tagline,
          ),
          MovieDetailSection(
            title: 'Overview',
            value: truncateText(movieDetail.overView),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
