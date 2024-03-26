import 'package:flutter/material.dart';
import 'package:s7_toktik/domain/entities/videos_post.dart';
import 'package:s7_toktik/presentation/widgets/video_buttons.dart';
import 'package:s7_toktik/presentation/widgets/video_player.dart';

class VideoScroll extends StatelessWidget {

  final List<VideoPost> videos;
  const VideoScroll({Key? key, required this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
        final video = videos[index];
        return Stack(
          children: [
            //view player + graidnet
            SizedBox.expand(
              child: VideoPlayerScreen(video: video.videoUrl, caption: video.caption,),
            ),
            //bottons
            Positioned(
              bottom: 40,
              right: 20,
              child: VideoButtons(vide: video,)
            )
          ],
        );
      },
      itemCount: videos.length,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      // children: [
      //   Container()
      // ],
    );
  }
}