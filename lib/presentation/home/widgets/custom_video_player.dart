import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domain/models/models.dart';
import 'widgets.dart';

class CustomVideoPlayer extends StatelessWidget {
  const CustomVideoPlayer({super.key, required this.video, required this.visible});

  final Video video;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YoutubePlayer(
          key: ObjectKey(video.id),
          controller: video.controller!,
          actionsPadding: const EdgeInsets.only(left: 16.0),
          bottomActions: [
            CurrentPosition(),
            const SizedBox(width: 10.0),
            ProgressBar(isExpanded: true),
            const SizedBox(width: 10.0),
            RemainingDuration(),
            FullScreenButton(),
          ],
        ),
        RatingScale(video: video, visible: visible)
      ],
    );
  }
}
