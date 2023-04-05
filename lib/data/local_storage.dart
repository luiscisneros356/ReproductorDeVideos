import 'package:path_provider/path_provider.dart';

import 'package:hive/hive.dart';
import 'package:verifarma/domain/models/models.dart';
import 'dart:developer' as dev;

class Boxes {
  static final videosDataBase = Hive.box<Video>("video");

  static Future initData() async {
    final directory = await getApplicationDocumentsDirectory();

    Hive
      ..init(directory.path)
      ..registerAdapter(VideoAdapter());
    await Hive.openBox<Video>("video");
  }

  static Future<void> addNewVideo(Video video) async {
    await videosDataBase.add(video);

    dev.log("${videosDataBase.values.length}");
  }
}
