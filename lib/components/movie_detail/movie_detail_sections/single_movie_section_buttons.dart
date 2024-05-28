import 'package:flutter/material.dart';

import '../../../components/movie_detail/movie_detail_sections/movie_detail_casts.dart';
import '../../../components/movie_detail/movie_detail_sections/movie_detail_credits.dart';
import '../../../components/movie_detail/movie_detail_sections/movie_detail_overview.dart';
import '../../../components/movie_detail/movie_detail_sections/movie_detail_posters.dart';
import '../../../components/movie_detail/movie_detail_sections/movie_detail_videos.dart';
import '../../../constants/colors.dart';
import '../../../dtos/movie_detail_dto.dart';

final List<String> allSections = [
  "Overview",
  "Cast",
  "Credits",
  "Videos",
  "Posters",
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
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: allSections.length,
            itemBuilder: (context, index) {
              final section = allSections[index];
              final isSelected = _currentPageIndex == index;
              return GestureDetector(
                onTap: () => _updateCurrentPageIndex(index),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.04,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? kPrimaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      section,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 380,
          child: PageView(
            controller: pageController,
            onPageChanged: _updateCurrentPageIndex,
            children: [
              MovieDetailOverview(
                movieDetail: widget.movieDetail,
              ),
              MovieDetailCasts(
                casts: widget.movieDetail.casts,
              ),
              MovieDetailCredits(
                movieCredit: widget.movieDetail.movieCredit,
              ),
              MovieDetailVideos(
                movieDetail: widget.movieDetail,
              ),
              MovieDetailPosters(
                movieDetail: widget.movieDetail,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
