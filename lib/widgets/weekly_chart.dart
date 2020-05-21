import 'dart:io';
import 'dart:math';

import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';

import '../models/completed_bubble.dart';

class WeeklyChart extends StatelessWidget {
  final Iterable<CompletedBubble> recentTransactions;
  final DateTime _fromDate = DateTime.now().subtract(Duration(days: 6));
  final DateTime _toDate = DateTime.now();

  WeeklyChart({this.recentTransactions});

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions.elementAt(i).completedDate.day == weekDay.day &&
            recentTransactions.elementAt(i).completedDate.month ==
                weekDay.month &&
            recentTransactions.elementAt(i).completedDate.year ==
                weekDay.year) {
          totalSum += 1;
        }
      }

      Random random = new Random();
      int randomNumber = random.nextInt(10);

      return {
        'day': weekDay,
        'amount': totalSum + randomNumber,
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 3,
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.55,
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: <Widget>[
          Text(
            'Your Bubbles in the past week\n(press and hold for more information)',
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline6.fontFamily,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            height: MediaQuery  .of(context).size.height * 0.46,
            width: MediaQuery.of(context).size.width,
            child: BezierChart(
              fromDate: _fromDate,
              bezierChartScale: BezierChartScale.WEEKLY,
              toDate: _toDate,
              selectedDate: _toDate,
              series: [
                BezierLine(
                  label: 'Bubble(s)',
                  onMissingValue: (dateTime) {
                    return 0.0;
                  },
                  data: groupedTransactionValues.map((data) {
                    return DataPoint<DateTime>(
                      value: data['amount'],
                      xAxis: data['day'],
                    );
                  }).toList(),
                ),
              ],
              config: BezierChartConfig(
                verticalIndicatorStrokeWidth: 3.0,
                verticalIndicatorColor: Theme.of(context).primaryColor,
                showVerticalIndicator: true,
                verticalIndicatorFixedPosition: false,
                backgroundColor: Theme.of(context).accentColor,
                footerHeight: 30.0,
                showDataPoints: true,
                bubbleIndicatorLabelStyle: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.headline6.fontFamily),
                bubbleIndicatorValueStyle: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.headline6.fontFamily),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
