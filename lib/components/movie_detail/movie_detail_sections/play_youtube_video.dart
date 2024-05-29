import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayYoutubeVideo extends StatefulWidget {
  final String youtubeId;

  const PlayYoutubeVideo({
    super.key,
    required this.youtubeId,
  });

  @override
  State<PlayYoutubeVideo> createState() => _PlayYoutubeVideoState();
}

class _PlayYoutubeVideoState extends State<PlayYoutubeVideo> {
  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _youtubePlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _youtubePlayerController,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.green,
      progressColors: const ProgressBarColors(
        playedColor: Colors.green,
        handleColor: Colors.greenAccent,
      ),
    );
  }
}
