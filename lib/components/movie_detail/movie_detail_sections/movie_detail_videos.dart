import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../components/movie_detail/movie_detail_sections/play_youtube_video.dart';
import '../../../constants/colors.dart';
import '../../../entities/video.dart';

class MovieDetailVideos extends StatelessWidget {
  const MovieDetailVideos({
    super.key,
    required this.videos,
  });

  final List<Video> videos;

  List<Video> sortTrailersFirst() {
    List<Video> sortedVideos = [];

    List<Video> trailerVideos = [];
    for (var video in videos) {
      if (video.type == 'Trailer') {
        trailerVideos.add(video);
        continue;
      }
      sortedVideos.add(video);
    }

    return [...trailerVideos, ...sortedVideos];
  }

  @override
  Widget build(BuildContext context) {
    final sortedVideos = sortTrailersFirst();
    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: ListView.builder(
        itemCount: sortedVideos.length,
        padding: const EdgeInsets.only(
          top: 10,
          left: 0,
          right: 0,
          bottom: 10,
        ),
        itemBuilder: (context, index) {
          final currentVideo = sortedVideos[index];
          return Container(
            height: 250,
            width: 250,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentVideo.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                PlayYoutubeVideo(
                  youtubeId: currentVideo.key,
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
