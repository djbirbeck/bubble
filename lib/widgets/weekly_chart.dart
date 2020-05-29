import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

import '../models/completed_bubble.dart';

class ChartBubbles {
  final DateTime weekDay;
  final int month;
  final int number;

  ChartBubbles({this.weekDay, this.month, this.number});
}

class WeeklyChart extends StatelessWidget {
  final Iterable<CompletedBubble> recentTransactions;

  WeeklyChart({this.recentTransactions});

  static List<charts.Series<ChartBubbles, int>> _groupedTransactionValues(
      recentTransactions, context) {
    var data = List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions.elementAt(i).completedDate.day == weekDay.day &&
            recentTransactions.elementAt(i).completedDate.month ==
                weekDay.month &&
            recentTransactions.elementAt(i).completedDate.year ==
                weekDay.year) {
          totalSum += 1;
        }
      }

      return ChartBubbles(
        weekDay: weekDay,
        month: weekDay.month,
        number: totalSum,
      );
    }).reversed.toList();

    return [
      new charts.Series<ChartBubbles, int>(
        id: 'Sales',
        domainFn: (ChartBubbles bubble, _) => bubble.weekDay.day,
        measureFn: (ChartBubbles bubble, _) => bubble.number,
        data: data,
        colorFn: (_, index) {
          return charts.MaterialPalette.indigo.makeShades(7)[index];
        },
        outsideLabelStyleAccessorFn: (ChartBubbles bubble, _) {
          final color = Theme.of(context).brightness == Brightness.light
              ? charts.MaterialPalette.black
              : charts.MaterialPalette.white;
          return new charts.TextStyleSpec(color: color);
        },
        labelAccessorFn: (ChartBubbles row, _) =>
            '${DateFormat.E().format(row.weekDay)}: ${row.number}',
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            'Your Bubbles\nin the past week',
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline6.fontFamily,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: charts.PieChart(
              _groupedTransactionValues(recentTransactions, context),
              animate: true,
              defaultRenderer: new charts.ArcRendererConfig(
                arcWidth: 10,
                arcRendererDecorators: [new charts.ArcLabelDecorator()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
