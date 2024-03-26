import 'package:s7_toktik/domain/entities/videos_post.dart';

abstract class VideoRepository {
  
  Future<List<VideoPost>> getVideoByPage ( int page );
  
  Future<List<VideoPost>> getFavsByUser ( String userId );

}
