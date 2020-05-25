import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/completed_bubble.dart';
import './bubble.dart';
import './weekly_chart.dart';

class Statistics extends StatelessWidget {
  transformSeconds(int seconds) {
    //Thanks to Andrew
    //int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();
    int days = (hours / 24).truncate();

    String hoursAfterDaysStr = (hours % 24).toString().padLeft(2, '0');
    //String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    //String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    // if (hoursStr == '00' && minutesStr == '00') {
    //   return '00:' + secondsStr;
    // } else if (hoursStr == '00') {
    //   return minutesStr + ':' + secondsStr;
    // } else
    if (days.toString() == '0') {
      if (minutesStr == '00') {
        return hoursAfterDaysStr + ':00';
      }
      return hoursAfterDaysStr + ':' + minutesStr;
    } else {
      return days.toString() + 'd ' + hoursAfterDaysStr + ':' + minutesStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Bubble(
                    size: 220,
                    isStatBubble: true,
                    childWidget: Center(
                      child: ValueListenableBuilder(
                        valueListenable:
                            Hive.box<CompletedBubble>('completedBubbles')
                                .listenable(),
                        builder: (context, Box<CompletedBubble> box, _) {
                          if (box.values.isEmpty) {
                            return Center(
                              child: Text(
                                'No. Bubbles...\never!',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                  fontSize: 20,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .fontFamily,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }

                          int totalMinutes = 0;
                          box.values.forEach((e) {
                            print(e.bubbleTemplate.workTime);
                            totalMinutes =  totalMinutes + e.bubbleTemplate.workTime;
                          });
                          int totalSeconds = totalMinutes * 60;

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                transformSeconds(totalSeconds),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                  fontSize: 24,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .fontFamily,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Bubblin\'',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Bubble(
                    size: 160,
                    isStatBubble: true,
                    childWidget: Center(
                      child: ValueListenableBuilder(
                        valueListenable:
                            Hive.box<CompletedBubble>('completedBubbles')
                                .listenable(),
                        builder: (context, Box<CompletedBubble> box, _) {
                          if (box.values.isEmpty) {
                            return Center(
                              child: Text(
                                '0',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                  fontSize: 20,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .fontFamily,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          var totalBubbles = box.values.length;

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                totalBubbles.toString(),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                  fontSize: 20,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .fontFamily,
                                ),
                              ),
                              Text(
                                '${totalBubbles == 1 ? 'Bubble' : 'Bubbles'}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable:
                Hive.box<CompletedBubble>('completedBubbles').listenable(),
            builder: (context, Box<CompletedBubble> box, _) {
              return WeeklyChart(recentTransactions: box.values);
            },
          ),
        ],
      ),
    );
  }
}
