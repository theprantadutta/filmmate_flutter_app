import 'package:filmmate_flutter_app/constants/colors.dart';
import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.2),
      ),
    );
  }
}
