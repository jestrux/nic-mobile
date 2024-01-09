import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoThumbnailImage extends StatefulWidget {
  final File file;
  const VideoThumbnailImage(this.file, {super.key});

  @override
  State<VideoThumbnailImage> createState() => _VideoThumbnailImageState();
}

class _VideoThumbnailImageState extends State<VideoThumbnailImage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          // width: 100,
          // height: 200,
          child: _controller.value.isInitialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    height: _controller.value.size?.height ?? 0,
                    width: _controller.value.size?.width ?? double.infinity,
                    child: VideoPlayer(_controller),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          left: 0,
          child: Container(
            color: Colors.black.withOpacity(0.4),
            alignment: Alignment.center,
            child: InkWell(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 32,
                ),
              ),
              onTap: () async {
                final double volume = 1.0;
                await _controller.setVolume(volume);
                await _controller.initialize();
                await _controller.setLooping(false);
                await _controller.play();
              },
            ),
          ),
        )
      ],
    );
  }
}
