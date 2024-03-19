import 'package:flutter/material.dart';
import 'package:s5_yesnoapp/domain/entities/message.dart';

class HerMessagBuble extends StatelessWidget {
  final Message message;
  const HerMessagBuble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.secondary,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(message.text, style: TextStyle(color: Colors.white),),
          ),
        ),
        const SizedBox(height: 5,),
        ImageBubble(imageUrl: message.imageUrl!,),
        const SizedBox(height: 5,),
      ],
    );
  }
}

class ImageBubble extends StatelessWidget {
  final String imageUrl;
  const ImageBubble({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        imageUrl,
        width: size.width * 0.7,
        height: 150,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if(loadingProgress == null) return child;
          return Container(
            width: size.width * 0.7,
            height: 150,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text("sending image..."),
          );
        },
      )
    );
  }
}