import 'package:flutter/material.dart';

class HerMessagBuble extends StatelessWidget {
  const HerMessagBuble({Key? key}) : super(key: key);

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
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text("Hola mundo", style: TextStyle(color: Colors.white),),
          ),
        ),
        const SizedBox(height: 5,),
        ImageBubble(),
        const SizedBox(height: 5,),
      ],
    );
  }
}

class ImageBubble extends StatelessWidget {
  const ImageBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        "https://yesno.wtf/assets/no/32-b62f1f8058c1d7f06c528319faccfb38.gif",
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