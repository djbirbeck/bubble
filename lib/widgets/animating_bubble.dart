import 'dart:async';

import 'package:flutter/material.dart';

class AnimatingBubble extends StatefulWidget {
  final bool isAnimating;
  final int animationDelay;

  const AnimatingBubble({this.isAnimating, this.animationDelay});

  @override
  _AnimatingBubbleState createState() => _AnimatingBubbleState();
}

class _AnimatingBubbleState extends State<AnimatingBubble>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
        } else if (status == AnimationStatus.dismissed && widget.isAnimating) {
          _controller.forward();
        }
      });
  }

  @override
  void didUpdateWidget(AnimatingBubble oldWidget) {
    if (widget.isAnimating) {
      Timer(Duration(milliseconds: widget.animationDelay), () {
        _controller.reset();
        _controller.forward();
      });
    } else {
      Timer(Duration(milliseconds: 500 + widget.animationDelay), () {
        _controller.reset();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBubble(animation: _animation);
  }
}

class AnimatedBubble extends AnimatedWidget {
  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 1, end: 0.2);
  static final _sizeTween = Tween<double>(begin: 0, end: 80);
  static final _bubbleColor =
      ColorTween(begin: Colors.blue[300], end: Colors.white);
  static final _borderColor =
      ColorTween(begin: Colors.grey[900], end: Colors.white);
  static final _borderWidth = Tween<double>(begin: 0, end: 2);

  AnimatedBubble({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: _borderColor.evaluate(animation),
              width: _borderWidth.evaluate(animation),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.cyan[50], _bubbleColor.evaluate(animation)],
            ),
          ),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
        ),
      ),
    );
  }
}
