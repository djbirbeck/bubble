import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import './timer_template.dart';

part 'completed_bubble.g.dart';

@HiveType(typeId: 1)
class CompletedBubble extends HiveObject {
  @HiveField(0)
  TimerTemplate bubbleTemplate;
  
  @HiveField(1)
  double amountOfBubbles;
  
  @HiveField(2)
  DateTime completedDate;

  CompletedBubble({
    @required this.bubbleTemplate,
    @required this.amountOfBubbles,
    @required this.completedDate,
  });
}
