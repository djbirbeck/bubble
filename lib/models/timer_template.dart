import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'timer_template.g.dart';

@HiveType(typeId: 3)
class TimerTemplate extends HiveObject {
  @HiveField(0)
  String title;
  
  @HiveField(1)
  int workTime;
  
  @HiveField(2)
  int restTime;

  TimerTemplate({
    @required this.title,
    @required this.workTime,
    @required this.restTime,
  });
}
