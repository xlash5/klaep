import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

Container myScreen(BuildContext context, VideoPlayerController? controller,
    VideoPlayerController? controller2, Color? color) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    color: color,
    child: Column(
      children: [
        Expanded(
          flex: 1,
          child: VideoPlayer(controller ??= VideoPlayerController.asset('')),
        ),
        Expanded(
          flex: 1,
          child: VideoPlayer(controller2 ??= VideoPlayerController.asset('')),
        ),
      ],
    ),
  );
}
