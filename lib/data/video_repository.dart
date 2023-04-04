import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:verifarma/domain/video_repository_imp.dart';

import '../domain/video_model.dart';

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

  @override
  Future<Video> postVideo() {
    return Future.value();
  }
}

// Future<File> localPath() async {
//   final directory = await getApplicationDocumentsDirectory();

//   final path = directory.path;
//   final file = File('$path/prueba.json');
//   return file.writeAsString("HOLLALALLA");
// }

// Future<void> pruebalocalPath() async {
//   final directory = await getApplicationDocumentsDirectory();

//   final path = directory.path;
//   print(path);

//   final file = File('$path/prueba.json');
//   try {
//     await file.writeAsString("texadasdadadst");
//     if (await file.exists()) {
//       print("HOLA MUNDO");
//     }

//     final prueba = await file.readAsString();
//     print(prueba);
//   } catch (e) {
//     print(e);
//   }

//   print(file);
//   // return file.writeAsString("!");
// }

// Future<File> writeCounter(int counter) async {
//   final file = await localFile;

//   // Write the file
//   return file.writeAsString('$counter');
// }
