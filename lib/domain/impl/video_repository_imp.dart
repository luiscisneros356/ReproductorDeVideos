import '../models/models.dart';

abstract class VideoRepositoryImpl {
  Future<List<Video>> getVideos();
}
