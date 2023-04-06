import 'package:flutter/material.dart';
import 'package:verifarma/data/local_storage.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:developer' as dev;

import '../impl/impl.dart';
import '../models/models.dart';

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
    Boxes.addNewVideo(video);
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
      dev.log("${_selectedVideo.rating} ");

      _selectedVideo.stars.add(Star(id: 0, starValue: _selectedVideo.currenteRankingPoint));

      if (Boxes.videosDataBase.values.contains(_selectedVideo)) {
        final videoInDataBase = Boxes.videosDataBase.values.firstWhere((video) => video.title == _selectedVideo.title);

        videoInDataBase.stars.add(Star(id: 0, starValue: _selectedVideo.currenteRankingPoint));

        Boxes.raitingVideo(videoInDataBase);
      } else {
        Boxes.addNewVideo(_selectedVideo);
      }

      dev.log("${_selectedVideo.rating} ");

      if (showRecomendation) {
        recomended();
      }

      notifyListeners();
    }

    notifyListeners();
  }

  void recomended() {
    _recomendedVideos = _listVideos.where((video) => video.title.contains(_selectedVideo.title)).toList();
    _recomendedVideos.sort((a, b) => b.rating.compareTo(a.rating));

    if (_recomendedVideos.length > 5) {
      _recomendedVideos = _recomendedVideos.getRange(0, 5).toList();
    }
  }

  Future<List<Video>> fetchVideos() async {
    final templistVideos = await _videoRepositoryImpl.getVideos();

    _listVideos.addAll(templistVideos);

    if (Boxes.videosDataBase.isNotEmpty) {
      _listVideos.addAll(Boxes.videosDataBase.values.toList());
      _listVideos = _listVideos.reversed.toList();
    }

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
