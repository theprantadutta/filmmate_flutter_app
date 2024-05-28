import 'package:filmmate_flutter_app/components/movie_detail/movie_detail_sections/play_youtube_video.dart';
import 'package:flutter/material.dart';

import '../../../dtos/video_dto.dart';

class MovieDetailVideos extends StatelessWidget {
  const MovieDetailVideos({
    super.key,
    required this.videos,
  });

  final List<VideoDto> videos;

  @override
  Widget build(BuildContext context) {
    for (final video in videos) {
      print(video.toJson());
    }
    return Container(
      child: const PlayYoutubeVideo(),
    );
  }
}
