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

    String daysStr = (days % 24).toString();
    String hoursAfterDaysStr = (hours % 24).toString();
    //String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    //String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    // if (hoursStr == '00' && minutesStr == '00') {
    //   return '00:' + secondsStr;
    // } else if (hoursStr == '00') {
    //   return minutesStr + ':' + secondsStr;
    // } else
    if (daysStr == '0') {
      if (minutesStr == '00') {
        return hoursAfterDaysStr + 'hrs';
      }
      return hoursAfterDaysStr + 'hrs ' + minutesStr;
    } else {
      return daysStr + 'd ' + hoursAfterDaysStr + ':' + minutesStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.73,
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
                          var smallBubbles = box.values.where((element) {
                            return element.bubbleType == 'small';
                          });

                          var bigBubbles = box.values.where((element) {
                            return element.bubbleType == 'big';
                          });

                          int smallTime = smallBubbles.length * 1800;
                          int bigTime = bigBubbles.length * 3600;

                          int totalTime = smallTime + bigTime;

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                transformSeconds(totalTime),
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
                              Text(
                                'spent Bubblin\' along',
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
                          var bigBubbles = box.values.where((element) {
                            return element.bubbleType == 'big';
                          });

                          if (box.values.isEmpty) {
                            return Center(
                              child: Text(
                                '0\nBig',
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
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                bigBubbles.length.toString(),
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
                                'Big',
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
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Bubble(
                    size: 120,
                    isStatBubble: true,
                    childWidget: Center(
                      child: ValueListenableBuilder(
                        valueListenable:
                            Hive.box<CompletedBubble>('completedBubbles')
                                .listenable(),
                        builder: (context, Box<CompletedBubble> box, _) {
                          var smallBubbles = box.values.where((element) {
                            return element.bubbleType == 'small';
                          });

                          if (box.values.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Small',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                smallBubbles.length.toString(),
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
                                'Small',
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
