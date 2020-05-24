import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import './timer_template.dart';

part 'bubble.g.dart';

@HiveType(typeId: 0)
class BubbleTask extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String title;
  
  @HiveField(2)
  String notes;
  
  @HiveField(3)
  TimerTemplate bubbleTemplate;
  
  @HiveField(4)
  double amountOfBubbles;
  
  @HiveField(5)
  int completedBubbles;
  
  @HiveField(6)
  double totalTime;
  
  @HiveField(7)
  DateTime dueDate;
  
  @HiveField(8)
  bool completed;

  BubbleTask({
    this.id,
    @required this.title,
    this.notes,
    @required this.bubbleTemplate,
    @required this.amountOfBubbles,
    this.completedBubbles,
    this.totalTime,
    @required this.dueDate,
    @required this.completed
  });
}
