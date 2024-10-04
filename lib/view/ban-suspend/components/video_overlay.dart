import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class PlayPauseOverlay extends StatefulWidget {
  final VideoPlayerController? controller;

  const PlayPauseOverlay({super.key, this.controller});

  @override
  PlayPauseOverlayState createState() => PlayPauseOverlayState();
}

class PlayPauseOverlayState extends State<PlayPauseOverlay> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.controller!.value.isPlaying) {
            widget.controller!.pause();
          } else {
            widget.controller!.play();
          }
        });
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 50),
        reverseDuration: const Duration(milliseconds: 200),
        child: widget.controller!.value.isPlaying
            ? const SizedBox.shrink()
            : Container(
          color: Colors.black26,
          child: const Center(
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 100.0,
              semanticLabel: 'Play',
            ),
          ),
        ),
      ),
    );
  }
}