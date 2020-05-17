import 'package:Bubble/widgets/bubble.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double amountOfBubbles;
  final double totalBubbles;

  const ChartBar({this.amountOfBubbles, this.totalBubbles});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 800),
          curve: Curves.bounceOut,
          height: totalBubbles <= 60 ? 60 : totalBubbles,
          width: totalBubbles <= 60 ? 60 : totalBubbles,
          child: Bubble(
            size: totalBubbles,
            isStatBubble: true,
            borderSize: 5,
            childWidget: Center(
              child: Text(
                '${amountOfBubbles.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
