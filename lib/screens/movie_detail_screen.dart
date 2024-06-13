import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/movie_detail/movie_detail_stack_on_poster.dart';
import '../components/movie_detail/single_movie_details.dart';
import '../screen_arguments/movie_detail_screen_arguments.dart';

class MovieDetailScreen extends StatelessWidget {
  static const kRouteName = '/movie-detail';

  const MovieDetailScreen({super.key});

  // late String _selected = allSections[0];
  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments
        as MovieDetailScreenArguments;
    final movie = args.movie;
    return Scaffold(
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: SafeArea(
          top: false,
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  minHeight: 0.0,
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                  child: MovieDetailStackOnPoster(
                    tagName: args.tagName,
                    movie: movie,
                  ),
                ),
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      SingleMovieDetails(movie: movie),
                  childCount: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
