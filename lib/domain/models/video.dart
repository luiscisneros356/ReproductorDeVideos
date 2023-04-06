import 'package:hive/hive.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'video.g.dart';

@HiveType(typeId: 2)
class Video extends HiveObject {
  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.stars,
    this.controller,
    this.currenteRankingPoint = 0,
  });
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  String url;
  @HiveField(4)
  final List<Star> stars;
  YoutubePlayerController? controller;

  int currenteRankingPoint = 0;

  double get rating {
    int totalPoints = 0;
    if (stars.isNotEmpty) {
      for (var star in stars) {
        totalPoints += star.starValue;
      }
      return totalPoints / stars.length;
    }
    return 0;
  }

  int get roundedStarRating => rating.round().clamp(0, 5);

  factory Video.empty() => Video(
        id: 1,
        title: "",
        description: "",
        url: "",
        stars: [],
      );

  Video copyWith(
          {int? id,
          String? title,
          String? description,
          String? url,
          List<Star>? stars,
          YoutubePlayerController? controller,
          int currenteRankingPoint = 0}) =>
      Video(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        controller: controller ?? this.controller,
        currenteRankingPoint: currenteRankingPoint,
        stars: stars ?? this.stars,
      );

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        stars: List<Star>.from(json["stars"].map((x) => Star.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "url": url,
        "stars": List<dynamic>.from(stars.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 4)
class Star {
  Star({
    required this.id,
    required this.starValue,
  });
  @HiveField(2)
  final int id;
  @HiveField(1)
  final int starValue;

  Star copyWith({
    int? id,
    int? starValue,
  }) =>
      Star(
        id: id ?? this.id,
        starValue: starValue ?? this.starValue,
      );

  factory Star.fromJson(Map<String, dynamic> json) => Star(
        id: json["id"],
        starValue: json["star_value"],
      );

  factory Star.empty() => Star(id: 0, starValue: 0);

  Map<String, dynamic> toJson() => {
        "id": id,
        "star_value": starValue,
      };
}
