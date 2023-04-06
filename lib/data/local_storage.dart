import 'package:path_provider/path_provider.dart';

import 'package:hive/hive.dart';
import 'package:verifarma/domain/models/models.dart';

class Boxes {
  static const videoBox = "video";
  static const userBox = "user";

  static final videosDataBase = Hive.box<Video>(videoBox);
  static final userDataBase = Hive.box<User>(userBox);

  static Future<void> initData() async {
    final directory = await getApplicationDocumentsDirectory();

    Hive
      ..init(directory.path)
      ..registerAdapter(VideoAdapter())
      ..registerAdapter(StarAdapter())
      ..registerAdapter(UserAdapter());
    await Hive.openBox<Video>(videoBox);
    await Hive.openBox<User>(userBox);
  }

  static Future<void> addNewVideo(Video video) async {
    await videosDataBase.add(video);
  }

  static Future<void> raitingVideo(Video video) async {
    await video.save();
  }

  static Future<void> currentUser(User user) async {
    await userDataBase.put(userBox, user);
  }

  static Future<void> deletedUser() async {
    await userDataBase.clear();
  }
}
