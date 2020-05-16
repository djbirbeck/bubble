import 'package:flutter/material.dart';

class Bubble extends StatefulWidget {
  final double size;
  final double elevation;
  final double borderSize;
  final Widget childWidget;
  final bool isStatBubble;

  const Bubble(
      {this.size,
      this.childWidget,
      this.elevation,
      this.borderSize,
      this.isStatBubble});

  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> with SingleTickerProviderStateMixin {
  double _borderSize;
  bool _isStatBubble;
  Color _statBorderColor;

  @override
  void initState() {
    widget.borderSize != null
        ? _borderSize = widget.borderSize
        : _borderSize = 3;
    widget.isStatBubble == null ? _isStatBubble = false : _isStatBubble = true;
    if (widget.size <= 149) {
      _statBorderColor = Colors.indigo[700];
    } else if (widget.size >= 150 && widget.size <= 199) {
      _statBorderColor = Colors.indigo;
    } else if (widget.size >= 200 && widget.size <= 249) {
      _statBorderColor = Colors.indigo[300];
    } else if (widget.size >= 250) {
      _statBorderColor = Colors.indigo[100];
    }
    super.initState();
  }

  @override
  void didUpdateWidget(Bubble oldWidget) {
    if (widget.size <= 149) {
      setState(() {
        _statBorderColor = Colors.indigo[700];
      });
    } else if (widget.size >= 150 && widget.size <= 199) {
      setState(() {
        _statBorderColor = Colors.indigo;
      });
    } else if (widget.size >= 200 && widget.size <= 249) {
      setState(() {
        _statBorderColor = Colors.indigo[300];
      });
    } else if (widget.size >= 250) {
      setState(() {
        _statBorderColor = Colors.indigo[100];
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: widget.size == 0
              ? Colors.transparent
              : Theme.of(context).brightness == Brightness.light
                  ? _isStatBubble ? _statBorderColor : Colors.grey[800]
                  : _isStatBubble ? _statBorderColor : Colors.grey[900],
          width: _borderSize,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _isStatBubble
              ? [Colors.transparent, Colors.transparent]
              : Theme.of(context).brightness == Brightness.light
                  ? [Colors.blue, Colors.cyan[300], Colors.cyan[300]]
                  : [Colors.blue[600], Colors.cyan[300]],
        ),
      ),
      child: widget.childWidget == null
          ? Container(
              color: Colors.transparent,
            )
          : widget.childWidget,
    );
  }
}
