// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intro.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IntroAdapter extends TypeAdapter<Intro> {
  @override
  final typeId = 2;

  @override
  Intro read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Intro(
      introCompleted: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Intro obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.introCompleted);
  }
}
