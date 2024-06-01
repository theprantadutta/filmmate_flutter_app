import 'package:flutter/material.dart';

import '../../../dtos/movie_detail_dto.dart';
import 'movie_overview_section.dart';

class MovieDetailOverview extends StatelessWidget {
  const MovieDetailOverview({
    super.key,
    required this.movieDetail,
  });

  final MovieDetailDto movieDetail;

  String getNamesFromArray(List<String> names) {
    if (names.isEmpty) {
      return 'N/A';
    }

    String str = '';
    for (var i = 0; i < names.length; i++) {
      if (i == 0) {
        str += names[i];
        continue;
      }
      str += ', ${names[i]}';
    }
    return str;
  }

  String formatNumber(int number) {
    if (number >= 1000000000) {
      // Convert to billions
      double billions = number / 1000000000;
      return '${billions.toStringAsFixed(2)} Billion';
    } else if (number >= 1000000) {
      // Convert to millions
      double millions = number / 1000000;
      return '${millions.toStringAsFixed(2)} Million';
    } else {
      // Less than a million, return as is
      return number.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
          right: 5.0,
          bottom: 10.0,
        ),
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
            MovieOverviewSection(
              title: 'Directed By: ',
              value: getNamesFromArray(movieDetail.movieCredit.directors),
            ),
            MovieOverviewSection(
              title: 'Written By: ',
              value: getNamesFromArray(movieDetail.movieCredit.writers),
            ),
            MovieOverviewSection(
              title: 'Story By: ',
              value: getNamesFromArray(movieDetail.movieCredit.storyBy),
            ),
            MovieOverviewSection(
              title: 'Produced By: ',
              value: getNamesFromArray(movieDetail.movieCredit.producers),
            ),
            MovieOverviewSection(
              title: 'Music By: ',
              value: getNamesFromArray(movieDetail.movieCredit.musicBy),
            ),
            MovieOverviewSection(
              title: 'Budget: ',
              value: movieDetail.budget != null
                  ? formatNumber(movieDetail.budget!)
                  : 'N/A',
            ),
            MovieOverviewSection(
              title: 'Revenue: ',
              value: movieDetail.revenue != null
                  ? formatNumber(movieDetail.revenue!)
                  : 'N/A',
            ),
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              movieDetail.overView,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
