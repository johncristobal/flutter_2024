import 'package:s7_toktik/domain/entities/videos_post.dart';

class LocalVidelModel {
    String name;
    String videoUrl;
    int likes;
    int views;

    LocalVidelModel({
        required this.name,
        required this.videoUrl,
        this.likes = 0,
        this.views = 0,
    });

    factory LocalVidelModel.fromJson(Map<String, dynamic> json) => LocalVidelModel(
        name: json["name"],
        videoUrl: json["videoUrl"],
        likes: json["likes"] ?? 0,
        views: json["views"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "videoUrl": videoUrl,
        "likes": likes,
        "views": views,
    };

    VideoPost toVideoPostEntity() {
      return VideoPost(
        caption: name, 
        videoUrl: videoUrl,
        likes: likes,
        views: views
      );
    }
}