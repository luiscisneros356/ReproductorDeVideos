// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoAdapter extends TypeAdapter<Video> {
  @override
  final int typeId = 2;

  @override
  Video read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Video(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      url: fields[3] as String,
      stars: (fields[4] as List).cast<Star>(),
    );
  }

  @override
  void write(BinaryWriter writer, Video obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.stars);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is VideoAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class StarAdapter extends TypeAdapter<Star> {
  @override
  final int typeId = 4;

  @override
  Star read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Star(
      id: 0,
      starValue: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Star obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.starValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is StarAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
