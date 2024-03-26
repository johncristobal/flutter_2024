import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s7_toktik/presentation/providers/discover_provider.dart';
import 'package:s7_toktik/presentation/widgets/video_scroll.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<DiscoverProvider>();

    return Scaffold(
      body: (provider.loading)
      ? const Center(child: CircularProgressIndicator(strokeWidth: 2,),)
      : VideoScroll(videos: provider.videos,)
    );
  }
}