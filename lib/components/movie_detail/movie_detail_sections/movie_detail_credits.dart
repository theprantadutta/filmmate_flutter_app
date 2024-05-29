import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../components/movie_detail/movie_detail_sections/credit_section.dart';
import '../../../dtos/movie_credit_dto.dart';

class MovieDetailCredits extends StatelessWidget {
  const MovieDetailCredits({
    super.key,
    required this.movieCredit,
  });

  final MovieCreditDto movieCredit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CreditSection(
            title: 'Directed By',
            names: movieCredit.directors,
          ),
          CreditSection(
            title: 'Written By',
            names: movieCredit.writers,
          ),
          CreditSection(
            title: 'Story By',
            names: movieCredit.storyBy,
          ),
          CreditSection(
            title: 'Produced By',
            names: movieCredit.producers,
          ),
          CreditSection(
            title: 'Music By',
            names: movieCredit.musicBy,
          ),
        ],
      ),
    );
  }
}
