// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intro.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IntroAdapter extends TypeAdapter<IntroToApp> {
  @override
  final typeId = 2;

  @override
  IntroToApp read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IntroToApp(
      introCompleted: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, IntroToApp obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.introCompleted);
  }
}
