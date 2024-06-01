import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/colors.dart';
import '../../../entities/movie.dart';

class PosterMiddlePart extends StatelessWidget {
  const PosterMiddlePart({
    super.key,
    required this.movie,
  });

  final Movie movie;

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
                Chip(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  side: const BorderSide(
                    color: kPrimaryColor,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 0,
                  ),
                  backgroundColor: kPrimaryColor.withOpacity(0.2),
                  label: Text(
                    movie.certification!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
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
            ),
          ),
          const CircleDivider(),
          Text(
            formatMovieRuntime(movie.runtime),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
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
