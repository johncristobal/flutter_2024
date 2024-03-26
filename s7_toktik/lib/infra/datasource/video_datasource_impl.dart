import 'package:s7_toktik/domain/datasource/video_datasource.dart';
import 'package:s7_toktik/domain/entities/videos_post.dart';
import 'package:s7_toktik/infra/models/local_video_model.dart';
import 'package:s7_toktik/share/data/local.dart';

class VideoDatasourceImpl implements VideoDatasource {

  @override
  Future<List<VideoPost>> getFavsByUser(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getVideoByPage(int page) async {
    await Future.delayed(const Duration(seconds:  2));
    final List<VideoPost> newVideos = videoPosts.map( 
      (video) => LocalVidelModel.fromJson( video ).toVideoPostEntity() 
    ).toList();

    return newVideos;
  }

}