import 'package:flutter/material.dart';

import 'package:verifarma/domain/video_model.dart';
import 'package:verifarma/domain/video_repository_imp.dart';

class VideosProvider extends ChangeNotifier {
  VideosProvider(this._videoRepositoryImpl);

  final VideoRepositoryImpl _videoRepositoryImpl;

  List<Video> _listVideos = [];
  List<Video> get listVideos => _listVideos;

  List<Video> _recomendedVideos = [];
  List<Video> get recomendedVideos => _recomendedVideos;

  Video _selectedVideo = Video.empty();
  Video get selectedVideo => _selectedVideo;

  bool get showRecomendation => selectedVideo.currenteRankingPoint > _selectedVideo.rating;

  void incrementRanking() {
    _selectedVideo.currenteRankingPoint++;
    notifyListeners();
  }

  void decrementRanking() {
    _selectedVideo.currenteRankingPoint--;
    notifyListeners();
  }

  void setVideo(Video video, [bool rate = false]) {
    _selectedVideo = video;

    if (rate) {
      _selectedVideo.stars.add(Star(id: 0, starValue: _selectedVideo.currenteRankingPoint));

      if (showRecomendation) {
        recomended();
      }

      notifyListeners();
    }

    notifyListeners();
  }

  recomended() {
    _recomendedVideos = _listVideos.where((video) => video.title.contains(_selectedVideo.title)).toList();
  }

  Future<List<Video>> fetchVideos() async {
    return _listVideos = await _videoRepositoryImpl.loadData();
  }
}
