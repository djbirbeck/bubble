import 'package:Bubble/widgets/bubble.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amountOfBubbles;
  final double totalBubbles;

  const ChartBar({this.label, this.amountOfBubbles, this.totalBubbles});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              curve: Curves.bounceOut,
              height: totalBubbles <= 60 ? 60 : totalBubbles,
              width: totalBubbles <= 60 ? 60 : totalBubbles,
              child: Bubble(size: totalBubbles, isStatBubble: true, borderSize: 5,),
            ),
            Text(
              '${amountOfBubbles.toStringAsFixed(0)}',
              style: TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        label == null
            ? Container()
            : Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline6.color,
                ),
              ),
      ],
    );
  }
}
