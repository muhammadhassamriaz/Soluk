import 'package:app/res/constants.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoPlayScreen extends StatelessWidget {
  final String videoPath;

  const VideoPlayScreen({Key? key, required this.videoPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child:videoPath.contains('http')? BetterPlayer.network(
            videoPath,
            betterPlayerConfiguration: const BetterPlayerConfiguration(
              aspectRatio: 16 / 9,
              autoPlay: false
            ),
          ):BetterPlayer.file(
            videoPath,
            betterPlayerConfiguration: const BetterPlayerConfiguration(
              aspectRatio: 16 / 9,
              autoPlay: false
            ),
          ),
        ),
      ),
    );
  }
}
