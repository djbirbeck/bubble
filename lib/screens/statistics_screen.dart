import 'package:flutter/material.dart';

import '../widgets/basic_scaffold.dart';
import '../widgets/hero_bubbles_stats.dart';
import '../widgets/statistics.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      screenTitle: 'Your Statistics',
      implyLeading: true,
      childWidget: Column(
        children: [
          HeroBubblesStats(),
          Statistics()
        ]
      ),
    );
  }
}