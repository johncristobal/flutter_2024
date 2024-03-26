import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:s7_toktik/config/helpers/human_formats.dart';
import 'package:s7_toktik/domain/entities/videos_post.dart';

class VideoButtons extends StatelessWidget {
  final VideoPost vide;
  const VideoButtons({Key? key, required this.vide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomIconButton(color: Colors.red, value: vide.likes, iconData: Icons.favorite,),
        const SizedBox(height: 20,),
        CustomIconButton(color: Colors.white, value: vide.views, iconData: Icons.remove_red_eye_outlined,),
        const SizedBox(height: 20,),
        SpinPerfect(
          infinite: true,
          duration: const Duration(seconds: 5),
          child: CustomIconButton(color: Colors.white, value: vide.likes, iconData: Icons.play_circle_fill_outlined,)),
      ],
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final int value;
  final IconData iconData;
  final Color color;
  const CustomIconButton({Key? key, required this.value, required this.iconData, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: (){},
          icon: Icon(iconData, color: color,size: 30,)
        ),
        Text(Formats.readerNumber(value.toDouble()))
      ],
    );
  }
}