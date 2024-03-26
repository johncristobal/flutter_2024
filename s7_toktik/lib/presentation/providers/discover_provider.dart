import 'package:flutter/material.dart';
import 'package:s7_toktik/domain/entities/videos_post.dart';
import 'package:s7_toktik/infra/models/local_video_model.dart';
import 'package:s7_toktik/share/data/local.dart';

class DiscoverProvider extends ChangeNotifier {

  bool loading = true;
  List<VideoPost> videos = [];

  Future<void> loadNext() async {

    await Future.delayed(const Duration(seconds: 2));
    final List<VideoPost> newVideos = videoPosts.map( (video) => LocalVidelModel.fromJson( video ).toVideoPostEntity() ).toList();

    videos.addAll(newVideos);
    loading = false;
    notifyListeners();
  }
}
