import 'package:filmmate_flutter_app/components/movie_detail/movie_detail_sections/movie_detail_casts.dart';
import 'package:filmmate_flutter_app/components/movie_detail/movie_detail_sections/movie_detail_credits.dart';
import 'package:filmmate_flutter_app/components/movie_detail/movie_detail_sections/movie_detail_overview.dart';
import 'package:filmmate_flutter_app/components/movie_detail/movie_detail_sections/movie_detail_posters.dart';
import 'package:filmmate_flutter_app/components/movie_detail/movie_detail_sections/movie_detail_videos.dart';
import 'package:filmmate_flutter_app/constants/colors.dart';
import 'package:filmmate_flutter_app/dtos/movie_detail_dto.dart';
import 'package:flutter/material.dart';

final List<String> allSections = [
  "Overview",
  "Cast",
  "Credits",
  "Videos",
  "Posters",
];

class SingleMovieSectionButtons extends StatefulWidget {
  // final String selected;
  // final void Function(String value) onPressed;
  final MovieDetailDto movieDetail;
  const SingleMovieSectionButtons({
    super.key,
    required this.movieDetail,
    // required this.selected,
    // required this.onPressed,
  });

  @override
  State<SingleMovieSectionButtons> createState() =>
      _SingleMovieSectionButtonsState();
}

class _SingleMovieSectionButtonsState extends State<SingleMovieSectionButtons> {
  final int _currentPageIndex = 0;
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
            children: [
              MovieDetailOverview(
                movieDetail: widget.movieDetail,
              ),
              MovieDetailCasts(
                movieDetail: widget.movieDetail,
              ),
              MovieDetailCredits(
                movieDetail: widget.movieDetail,
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
