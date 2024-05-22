import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class MovieDetailAnotherSection extends StatelessWidget {
  final String title;
  final String value;

  const MovieDetailAnotherSection({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 10),
            Chip(
              label: Text(value),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
