import 'package:filmmate_flutter_app/components/common/custom_outlined_button.dart';
import 'package:flutter/material.dart';

import '../components/layouts/main_layout.dart';
import '../screen_arguments/movie_detail_screen_arguments.dart';

class MovieDetailScreen extends StatelessWidget {
  static const kRouteName = '/movie-detail';
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments
        as MovieDetailScreenArguments;
    final movie = args.movie;
    return MainLayout(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.55,
        leading: Stack(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
          ],
        ),
        flexibleSpace: Hero(
          tag: args.tagName,
          child: Image(
            image: NetworkImage(
              'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: ListView.builder(
                itemCount: movie.genres.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final genre = movie.genres[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CustomOutlinedButton(title: genre.name),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
