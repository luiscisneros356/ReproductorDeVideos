import 'package:path_provider/path_provider.dart';

import 'package:hive/hive.dart';
import 'package:verifarma/domain/models/models.dart';
import 'dart:developer' as dev;

class Boxes {
  static const videoBox = "video";

  static final videosDataBase = Hive.box<Video>(videoBox);

  static Future<void> initData() async {
    final directory = await getApplicationDocumentsDirectory();

    Hive
      ..init(directory.path)
      ..registerAdapter(VideoAdapter())
      ..registerAdapter(StarAdapter());
    await Hive.openBox<Video>(videoBox);
  }

  static Future<void> addNewVideo(Video video) async {
    await videosDataBase.add(video);

    dev.log("${videosDataBase.values.length}");
  }

  static Future<void> raitingVideo(Video video) async {
    video.save();
    dev.log("${videosDataBase.values.length}");
  }
}
