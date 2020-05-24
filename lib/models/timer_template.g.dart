// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_template.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimerTemplateAdapter extends TypeAdapter<TimerTemplate> {
  @override
  final typeId = 3;

  @override
  TimerTemplate read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimerTemplate(
      title: fields[0] as String,
      workTime: fields[1] as int,
      restTime: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TimerTemplate obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.workTime)
      ..writeByte(2)
      ..write(obj.restTime);
  }
}
