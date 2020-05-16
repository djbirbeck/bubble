// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_bubble.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompletedBubbleAdapter extends TypeAdapter<CompletedBubble> {
  @override
  final typeId = 1;

  @override
  CompletedBubble read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompletedBubble(
      bubbleType: fields[0] as String,
      amountOfBubbles: fields[1] as double,
      completedDate: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CompletedBubble obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.bubbleType)
      ..writeByte(1)
      ..write(obj.amountOfBubbles)
      ..writeByte(2)
      ..write(obj.completedDate);
  }
}
