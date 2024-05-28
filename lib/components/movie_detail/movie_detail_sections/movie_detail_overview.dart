import 'package:flutter/material.dart';

import '../../../dtos/movie_detail_dto.dart';
import '../../../util/functions.dart';

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
          const SizedBox(height: 10),
          Text(
            movieDetail.tagline != null ? movieDetail.tagline! : 'N/A',
            style: const TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'Release Date: ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                movieDetail.releaseDate != null
                    ? '${movieDetail.releaseDate} (${movieDetail.status})'
                    : 'N/A',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Overview',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            truncateText(movieDetail.overView),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
