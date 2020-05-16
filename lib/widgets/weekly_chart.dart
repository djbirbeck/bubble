import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/bubble.dart';

class WeeklyChart extends StatelessWidget {
  final List<BubbleTask> recentTransactions;

  WeeklyChart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].dueDate.day == weekDay.day &&
            recentTransactions[i].dueDate.month == weekDay.month &&
            recentTransactions[i].dueDate.year == weekDay.year) {
          totalSum += recentTransactions[i].completedBubbles;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(horizontal:8, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
      color: Theme.of(context).primaryColorLight,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text('Your past week!', style: TextStyle(color: Theme.of(context).primaryColorDark),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: data['day'],
                    amountOfBubbles: data['amount'],
                    totalBubbles: totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
