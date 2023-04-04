import 'dart:convert';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Video videoFromJson(String str) => Video.fromJson(json.decode(str));

String videoToJson(Video data) => json.encode(data.toJson());

class Video {
  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.stars,
  });

  final int id;
  final String title;
  final String description;
  String url;
  final List<Star> stars;
  YoutubePlayerController? controller;
  int currenteRankingPoint = 0;

  double get rating {
    int totalPoints = 0;
    for (var star in stars) {
      totalPoints += star.starValue;
    }
    return totalPoints / stars.length;
  }

  int get roundedStarRating => rating.round().clamp(0, 5);

  factory Video.empty() => Video(
        id: 1,
        title: "",
        description: "",
        url: "",
        stars: [],
      );

  Video copyWith({
    int? id,
    String? title,
    String? description,
    String? url,
    List<Star>? stars,
  }) =>
      Video(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
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

class Star {
  Star({
    required this.id,
    required this.starValue,
  });

  final int id;
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
