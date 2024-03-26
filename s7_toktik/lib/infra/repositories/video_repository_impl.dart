import 'package:s7_toktik/domain/datasource/video_datasource.dart';
import 'package:s7_toktik/domain/entities/videos_post.dart';
import 'package:s7_toktik/domain/repositories/video_repo.dart';

class VideoRepositoryImpl implements VideoRepository {

  final VideoDatasource datasource;

  VideoRepositoryImpl({required this.datasource});

  @override
  Future<List<VideoPost>> getFavsByUser(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getVideoByPage(int page) {
    return datasource.getVideoByPage(page);
  }

}