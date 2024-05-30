import 'package:flutter/material.dart';

import '../../entities/movie.dart';

class MovieDetailStackOnPoster extends StatelessWidget {
  final String tagName;
  final Movie movie;

  const MovieDetailStackOnPoster({
    super.key,
    required this.tagName,
    required this.movie,
  });

  String _doubleToPercentageString(double value) {
    return '${(value * 10).toInt().toString()}%';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          child: Hero(
            tag: tagName,
            child: Image(
              image: NetworkImage(
                'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 25,
          left: 10,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            color: Colors.black.withOpacity(0.7),
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: movie.voteAverage != null
                      ? MediaQuery.of(context).size.width * 0.75
                      : MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: movie.genres.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final genre = movie.genres.toList()[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                ),
                                child: Text(genre.name),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                if (movie.voteAverage != null)
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: CircleAvatar(
                        radius: 25,
                        child: Text(
                          _doubleToPercentageString(movie.voteAverage!),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
