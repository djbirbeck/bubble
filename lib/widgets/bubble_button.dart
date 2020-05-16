import 'package:flutter/material.dart';

class BubbleButton extends StatelessWidget {
  final double bubbleSizeMin;
  final double bubbleSizeMax;
  final bool selected;

  const BubbleButton({this.bubbleSizeMin, this.bubbleSizeMax, this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        height: selected ? bubbleSizeMax : bubbleSizeMin,
        width: selected ? bubbleSizeMax : bubbleSizeMin,
        curve: Curves.bounceOut,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? Colors.lightBlueAccent[100] : Theme.of(context).brightness == Brightness.light ? Colors.grey[50] : Colors.blue[900],
            width: 2,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              selected ? Colors.purple[200] : Colors.lightBlueAccent[100],
              selected ? Colors.lightBlueAccent[100] : Theme.of(context).brightness == Brightness.light ? Colors.blue[100] : Colors.blue[900],
              selected ? Colors.tealAccent[100] : Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.indigo[900],
              selected ? Colors.tealAccent[100] : Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.indigo[900],
            ],
          ),
        ),
    );
  }
}
