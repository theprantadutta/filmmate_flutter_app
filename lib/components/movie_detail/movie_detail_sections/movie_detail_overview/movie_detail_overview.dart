import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../dtos/movie_detail_dto.dart';
import '../../../../util/functions.dart';
import '../movie_overview_section.dart';
import 'movie_reviews.dart';

class MovieDetailOverview extends StatelessWidget {
  const MovieDetailOverview({
    super.key,
    required this.movieDetail,
  });

  final MovieDetailDto movieDetail;

  String getNamesFromArray(List<String>? names) {
    if (names == null || names.isEmpty) {
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
    if (number == 0) {
      return 'N/A';
    }

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
    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
          right: 5.0,
          bottom: 10.0,
        ),
        child: SingleChildScrollView(
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
              MovieReviews(
                imdbRating: movieDetail.imdbRating,
                rottenTomatoesScore: movieDetail.rottenTomatoesScore,
                metaCriticScore: movieDetail.metaCriticScore,
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
                truncateText(movieDetail.overView),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieDetailOverviewSkeletor extends StatelessWidget {
  const MovieDetailOverviewSkeletor({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
          right: 5.0,
          bottom: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Some Movie Tagline',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(height: 10),
              const MovieReviewsSkeletor(),
              const SizedBox(height: 10),
              const MovieOverviewSectionSkeletor(),
              const MovieOverviewSectionSkeletor(),
              const MovieOverviewSectionSkeletor(),
              const MovieOverviewSectionSkeletor(),
              const MovieOverviewSectionSkeletor(),
              const MovieOverviewSectionSkeletor(),
              const MovieOverviewSectionSkeletor(),
              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                truncateText(
                    'Wrote water woman of heart it total other. By in entirely securing suitable graceful at families improved. Zealously few furniture repulsive was agreeable consisted difficult. Collected breakfast estimable questions in to favourite it. Known he place worth words it as to. Spoke now noise off smart her ready.'),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
