import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:verifarma/domain/video_repository_imp.dart';

import '../domain/video_model.dart';

const dataJson = "assets/data.json";

class VideoRepository extends VideoRepositoryImpl {
  @override
  Future<List<Video>> loadData() async {
    List<Video> listVideos = [];

    await rootBundle.loadString(dataJson).then((value) {
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
