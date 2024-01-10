import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nic/constants.dart';
import 'package:video_player/video_player.dart';

class PlayVideoPage extends StatefulWidget {
  final File video;
  const PlayVideoPage({required this.video, super.key});

  @override
  PlayVideoPageState createState() => PlayVideoPageState();
}

class PlayVideoPageState extends State<PlayVideoPage> {
  late VideoPlayerController _controller;
  bool playing = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(widget.video);
    _controller.setLooping(false);
    _controller.initialize().then((_) {
      _controller.play();
      setState(() {
        playing = true;
      });
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

  Widget _buildContent() {
    if (!_controller.value.isInitialized) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 40),
        child: const SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.white,
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          VideoPlayer(_controller),
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Constants.darkAppBarTheme(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Video Preview"),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: _buildContent(),
        ),
      ),
    );
  }
}
