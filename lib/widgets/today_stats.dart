import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './day_chart.dart';
import '../models/completed_bubble.dart';

class TodayStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'Today\'s Completed\nBubbles',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        Spacer(),
        ValueListenableBuilder(
          valueListenable:
              Hive.box<CompletedBubble>('completedBubbles').listenable(),
          builder: (context, Box<CompletedBubble> box, _) {
            if (box.values.isEmpty) {
              return Center(
                child: Text(
                  '0',
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            }
            return Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: DayChart(box.values),
              ),
            );
          },
        ),
        Spacer(),
      ],
    );
  }
}
