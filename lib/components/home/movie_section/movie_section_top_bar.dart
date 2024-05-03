import 'package:flutter/material.dart';

class MovieSectionTopBar extends StatelessWidget {
  final String title;

  const MovieSectionTopBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      // height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'See All',
            style: TextStyle(
              fontSize: 14,
              color: isDarkTheme ? Colors.grey.shade500 : Colors.grey.shade600,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
