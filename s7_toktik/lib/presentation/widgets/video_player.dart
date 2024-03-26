import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String video;
  final String caption;
  VideoPlayerScreen({Key? key, required this.video, required this.caption}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
       widget.video,
    )
    ..setVolume(0)
    ..setLooping(true)
    ..play();

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            // Use the VideoPlayer widget to display the video.
            child: Stack(
              children: [
                VideoPlayer(_controller),
                const GradientBackground(),
                Positioned(
                  child: _VideoCaption(caption: widget.caption),
                  bottom: 50, 
                  left: 20,
                )
              ],
            ),
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2,),
          );
        }
      },
    );
  }
}

class _VideoCaption extends StatelessWidget {

  final String caption;
  const _VideoCaption({Key? key, required this.caption}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.6,
      child: Text(caption, maxLines: 2,),
    );
  }
}

class GradientBackground extends StatelessWidget {
  const GradientBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black
            ],
            stops: [0.8, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
      )
    );
  }
}