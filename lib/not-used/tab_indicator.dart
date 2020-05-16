import 'package:flutter/material.dart';

import './indicator_bubble.dart';

class TabIndicator extends StatelessWidget {
  final int tabIndex;

  const TabIndicator({this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(bottom: 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IndicatorBubble(
          size: tabIndex == 0 ? 0 : 30,
        ),
        IndicatorBubble(
          size: tabIndex == 1 ? 0 : 30,
        ),
        IndicatorBubble(
          size: tabIndex == 2 ? 0 : 30,
        ),
        IndicatorBubble(
          size: tabIndex == 3 ? 0 : 30,
        ),
      ]),
    );
  }
}
