import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  final String tagName;
  final String? posterPath;

  const MoviePoster({
    super.key,
    required this.tagName,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      child: Hero(
        tag: tagName,
        child: Image(
          image: NetworkImage(
            'https://image.tmdb.org/t/p/w500/$posterPath',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
