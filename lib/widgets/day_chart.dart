import 'package:flutter/material.dart';

import './chart_bar.dart';
import '../models/completed_bubble.dart';

class DayChart extends StatelessWidget {
  final Iterable<CompletedBubble> recentTransactions;

  DayChart(this.recentTransactions);

  double get todayValue {
    final today = DateTime.now();
    var totalSum = 0.0;

    for (var i = 0; i < recentTransactions.length; i++) {
      if (recentTransactions.elementAt(i).completedDate.day == today.day &&
          recentTransactions.elementAt(i).completedDate.month == today.month &&
          recentTransactions.elementAt(i).completedDate.year == today.year) {
        totalSum += 1.0;
      }
    }

    return totalSum;
  }

  // double get totalSpending {
  //   return todayValue;
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ChartBar(
          amountOfBubbles: todayValue,
          totalBubbles: (todayValue * 25) >= 300 ? 300 : todayValue * 25,
        ),
      );
  }
}
