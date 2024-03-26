import 'package:flutter/material.dart';
import 'package:s7_toktik/domain/entities/videos_post.dart';
import 'package:s7_toktik/domain/repositories/video_repo.dart';

class DiscoverProvider extends ChangeNotifier {

  final VideoRepository repo;
  // final VideoRepositoryImpl repo;

  bool loading = true;
  List<VideoPost> videos = [];

  DiscoverProvider({required this.repo});

  Future<void> loadNext() async {

    // await Future.delayed(const Duration(seconds: 2));
    // final List<VideoPost> newVideos = videoPosts.map( 
    //   (video) => LocalVidelModel.fromJson( video ).toVideoPostEntity() 
    // ).toList();
    final newVideos = await repo.getVideoByPage(1);

    videos.addAll(newVideos);
    loading = false;
    notifyListeners();
  }
}
