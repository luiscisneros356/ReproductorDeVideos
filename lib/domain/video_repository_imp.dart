import 'package:verifarma/domain/video_model.dart';

abstract class VideoRepositoryImpl {
  Future<List<Video>> getVideos();
  Future<Video> postVideo();
}
