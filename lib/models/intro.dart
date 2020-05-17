import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'intro.g.dart';

@HiveType(typeId: 2)
class IntroToApp extends HiveObject {
  @HiveField(0)
  bool introCompleted;

  IntroToApp({
    @required this.introCompleted,
  });
}
