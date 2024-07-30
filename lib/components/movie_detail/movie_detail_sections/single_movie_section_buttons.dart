import 'package:flutter/material.dart';

import '../../../components/movie_detail/movie_detail_sections/movie_detail_casts.dart';
import '../../../components/movie_detail/movie_detail_sections/movie_detail_posters.dart';
import '../../../components/movie_detail/movie_detail_sections/movie_detail_recommendations.dart';
import '../../../components/movie_detail/movie_detail_sections/movie_detail_videos.dart';
import '../../../constants/colors.dart';
import '../../../dtos/movie_detail_dto.dart';
import 'movie_detail_overview/movie_detail_overview.dart';

final List<String> allSections = [
  "Overview",
  "Cast",
  "Videos",
  "Posters",
  "Top Picks",
];

class SingleMovieSectionButtons extends StatefulWidget {
  final MovieDetailDto movieDetail;
  const SingleMovieSectionButtons({
    super.key,
    required this.movieDetail,
  });

  @override
  State<SingleMovieSectionButtons> createState() =>
      _SingleMovieSectionButtonsState();
}

class _SingleMovieSectionButtonsState extends State<SingleMovieSectionButtons> {
  int _currentPageIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(
      initialPage: _currentPageIndex,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void _updateCurrentPageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: Row(
              children: allSections.map((section) {
                final index = allSections.indexOf(section);
                final isSelected = _currentPageIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _updateCurrentPageIndex(index),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      margin: const EdgeInsets.symmetric(
                        // horizontal: 5,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? kPrimaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          section,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ];
      },
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.8,
        child: PageView(
          physics: const ClampingScrollPhysics(),
          controller: pageController,
          onPageChanged: (value) => setState(
            () => _currentPageIndex = value,
          ),
          children: [
            MovieDetailOverview(
              movieDetail: widget.movieDetail,
            ),
            MovieDetailCasts(
              casts: widget.movieDetail.casts.toList(),
            ),
            MovieDetailVideos(
              videos: widget.movieDetail.videos.toList(),
            ),
            MovieDetailPosters(
              posters: widget.movieDetail.images.posters,
            ),
            MovieDetailRecommendations(
              recommendedMovies: widget.movieDetail.recommendedMovies.toList(),
            ),
          ],
        ),
      ),
    );
  }
}
