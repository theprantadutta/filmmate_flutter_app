import 'package:flutter/material.dart';

class MovieAverageVote extends StatelessWidget {
  final double voteAverage;

  const MovieAverageVote({
    super.key,
    required this.voteAverage,
  });

  String _doubleToPercentageString(double value) {
    return '${(value * 10).toInt().toString()}%';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
        child: CircleAvatar(
          radius: 25,
          child: Text(
            _doubleToPercentageString(voteAverage),
          ),
        ),
      ),
    );
  }
}
