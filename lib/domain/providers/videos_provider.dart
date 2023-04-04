import 'package:flutter/material.dart';

import 'package:verifarma/domain/video_model.dart';
import 'package:verifarma/domain/video_repository_imp.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosProvider extends ChangeNotifier {
  VideosProvider(this._videoRepositoryImpl);

  final VideoRepositoryImpl _videoRepositoryImpl;

  List<Video> _listVideos = [];
  List<Video> get listVideos => _listVideos;

  List<Video> _recomendedVideos = [];
  List<Video> get recomendedVideos => _recomendedVideos;

  final List<Video> _listNewVideos = [];
  List<Video> get listNewVideos => _listNewVideos;

  void setAddNewVideo(Video video) {
    _listNewVideos.add(video);
  }

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

      print(_listVideos.length);

      if (showRecomendation) {
        recomended();
      }

      notifyListeners();
    }

    notifyListeners();
  }

  recomended() {
    _recomendedVideos = _listVideos.where((video) => video.title.contains(_selectedVideo.title)).toList();
    _recomendedVideos.sort((a, b) => b.rating.compareTo(a.rating));
  }

  Future<List<Video>> fetchVideos() async {
    _listVideos = await _videoRepositoryImpl.getVideos();

    if (_listNewVideos.isNotEmpty) {
      _listVideos.addAll(_listNewVideos);
      _listVideos = _listVideos.reversed.toList();
    }

    for (var video in _listVideos) {
      video.controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(video.url)!,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
          ));
    }

    return _listVideos;
  }
}
