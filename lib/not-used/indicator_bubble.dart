import 'package:flutter/material.dart';

class IndicatorBubble extends StatefulWidget {
  final double size;
  final Widget childWidget;
  final double elevation;

  const IndicatorBubble({
    this.size,
    this.childWidget,
    this.elevation,
  });

  @override
  _IndicatorBubbleState createState() => _IndicatorBubbleState();
}

class _IndicatorBubbleState extends State<IndicatorBubble>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: widget.size == 0 ? 20 : 12,
      width: widget.size == 0 ? 20 : 12,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              widget.size == 0 ? Colors.teal[50] : Colors.indigo[400],
          width: 2,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.size == 0 ? Colors.tealAccent : Colors.lightBlue[200],
            widget.size == 0 ? Colors.blue : Colors.lightBlue,
          ],
        ),
      ),
    );
  }
}
