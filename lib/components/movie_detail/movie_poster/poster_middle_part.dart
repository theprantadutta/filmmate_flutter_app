import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/colors.dart';
import '../../../dtos/movie_dto.dart';

class PosterMiddlePart extends StatelessWidget {
  const PosterMiddlePart({
    super.key,
    required this.movie,
  });

  final MovieDto movie;

  String formatMovieRuntime(int? totalMinutes) {
    if (totalMinutes == null) {
      return 'N/A';
    }
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 2,
      ),
      child: Row(
        children: [
          if (movie.certification != null)
            Row(
              children: [
                Container(
                  height: 30,
                  // width: 60,
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      movie.certification!,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const CircleDivider(),
              ],
            ),
          Text(
            movie.releaseDate != null
                ? DateFormat('d MMM, yyyy').format(movie.releaseDate!)
                : 'N/A',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const CircleDivider(),
          Text(
            formatMovieRuntime(movie.runtime),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class CircleDivider extends StatelessWidget {
  const CircleDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 5),
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}
