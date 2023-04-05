import 'dart:convert';

import 'package:flutter/services.dart';

import '../domain/impl/video_repository_imp.dart';
import '../domain/models/models.dart';

const dataJsonFile = "assets/data.json";

class VideoRepository extends VideoRepositoryImpl {
  @override
  Future<List<Video>> getVideos() async {
    List<Video> listVideos = [];

    await rootBundle.loadString(dataJsonFile).then((value) {
      final videos = jsonDecode(value)["data"] as List;
      videos
          .map(
            (video) => listVideos.add(
              Video.fromJson(video),
            ),
          )
          .toList();
    });

    return listVideos;
  }
}
