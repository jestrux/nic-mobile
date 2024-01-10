import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoThumbnailImage extends StatefulWidget {
  final File file;
  final bool previewOnly;
  const VideoThumbnailImage(this.file, {this.previewOnly = false, super.key});

  @override
  State<VideoThumbnailImage> createState() => _VideoThumbnailImageState();
}

class _VideoThumbnailImageState extends State<VideoThumbnailImage> {
  late VideoPlayerController _controller;
  bool playing = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file);
    _controller.setLooping(false);
    _controller.initialize().then((_) {
      setState(() {});
      _controller.addListener(() {
        setState(() {
          playing = _controller.value.isPlaying;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
          ),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            height: _controller.value.size?.height ?? 0,
            width: _controller.value.size?.width ?? double.infinity,
            child: VideoPlayer(_controller),
          ),
        ),
        ...(widget.previewOnly
            ? []
            : [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 50),
                  reverseDuration: const Duration(milliseconds: 200),
                  child: playing
                      ? const SizedBox.shrink()
                      : const ColoredBox(
                          color: Colors.black26,
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 100.0,
                              semanticLabel: 'Play',
                            ),
                          ),
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();

                    setState(() {
                      playing = !playing;
                    });
                  },
                ),
              ])
      ],
    );
  }
}
