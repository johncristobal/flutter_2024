import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SliderInfo {
  final String title;
  final String caption;
  final String image;

  SliderInfo({required this.title, required this.caption, required this.image});
}

final slides = <SliderInfo> [
  SliderInfo(title: "Bisca comida", caption: "Qui sit deserunt exercitation est aute esse pariatur laboris incididunt eiusmod excepteur non.", image: "assets/1.png"),
  SliderInfo(title: "Entrega comida", caption: "Nostrud nulla consequat voluptate laboris sint exercitation nostrud fugiat adipisicing enim laboris culpa magna esse.", image: "assets/2.png"),
  SliderInfo(title: "Disfruta comida", caption: "Do eiusmod ad et veniam anim exercitation aliquip anim est et deserunt aliquip quis in.", image: "assets/3.png"),
];

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);
  static const name = "tutorial_screen";

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {

  late final PageController controller;
  bool endReach = false;

  @override
  void initState() {
    super.initState();

    controller = PageController();
    controller.addListener(() { 
      final page = controller.page ?? 0;
      if(!endReach && page >= (slides.length - 1.5)){
        setState(() {
          endReach = true;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            children: slides.map((e) => _Slide(info: e)).toList(),
          ),

          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              child: Text("Skip"),
              onPressed: (){ context.pop(); },
            ),
          ),

          endReach ? Positioned(
            bottom: 24,
            right: 24,
            child: FilledButton(
              child: Text("Empezar"),
              onPressed: (){ context.pop(); },
            ),
          ) : Container()
        ],
      ),
    );
  }
}


class _Slide extends StatelessWidget {

  final SliderInfo info;
  const _Slide({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(info.image),),
            const SizedBox(height: 20,),
            Text(info.title),
            const SizedBox(height: 20,),
            Text(info.caption)
          ],
        ),
      ),
    );
  }
}