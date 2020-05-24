// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bubble.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BubbleTaskAdapter extends TypeAdapter<BubbleTask> {
  @override
  final typeId = 0;

  @override
  BubbleTask read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BubbleTask(
      id: fields[0] as String,
      title: fields[1] as String,
      notes: fields[2] as String,
      bubbleTemplate: fields[3] as TimerTemplate,
      amountOfBubbles: fields[4] as double,
      completedBubbles: fields[5] as int,
      totalTime: fields[6] as double,
      dueDate: fields[7] as DateTime,
      completed: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BubbleTask obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.notes)
      ..writeByte(3)
      ..write(obj.bubbleTemplate)
      ..writeByte(4)
      ..write(obj.amountOfBubbles)
      ..writeByte(5)
      ..write(obj.completedBubbles)
      ..writeByte(6)
      ..write(obj.totalTime)
      ..writeByte(7)
      ..write(obj.dueDate)
      ..writeByte(8)
      ..write(obj.completed);
  }
}
