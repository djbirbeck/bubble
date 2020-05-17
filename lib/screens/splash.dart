import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/begin_button.dart';
import '../widgets/bubble.dart';
import './home_screen.dart';
import '../transitions/fade.dart';
import '../widgets/basic_scaffold.dart';

class Splash extends StatefulWidget {
  final Function switchFunction;

  const Splash({this.switchFunction});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  double _logoSize;
  double _bubble1Size;
  double _bubble2Size;

  Widget _button = Container(
    height: 30,
  );

  @override
  void initState() {
    _logoSize = 0;
    _bubble1Size = 0;
    _bubble2Size = 0;
    _animateIn();
    super.initState();
  }

  void _animateIn() {
    Timer(Duration(milliseconds: 400), () {
      setState(() {
        _logoSize = MediaQuery.of(context).size.height * 0.2;
      });
      Timer(Duration(milliseconds: 200), () {
        setState(() {
          _bubble1Size = MediaQuery.of(context).size.height * 0.15;
        });
        Timer(Duration(milliseconds: 200), () {
          setState(() {
            _bubble2Size = MediaQuery.of(context).size.height * 0.1;
          });
        });
      });
    });

    Timer(Duration(milliseconds: 1300), () {
      setState(() {
        _button = BeginButton(
          animateButtonFunction: _animatePreTransition,
        );
      });
    });
  }

  void _animatePreTransition() {
    setState(() {
      _button = Container();
    });
    Timer(Duration(milliseconds: 400), () {
      Navigator.pushReplacement(
        context,
        FadeRoute(
          page: HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      childWidget: Stack(
        children: [
          Positioned(
            top: 30,
            left: 60,
            child: AnimatedContainer(
              curve: Curves.bounceOut,
              height: _bubble1Size,
              width: _bubble1Size,
              duration: Duration(milliseconds: 600),
              margin: EdgeInsets.only(right: 80, bottom: 600),
              child: Hero(
                tag: 'bubble-1',
                child: Bubble(size: _bubble1Size),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: 100,
            child: Center(
              child: AnimatedContainer(
                curve: Curves.bounceOut,
                height: _bubble2Size,
                width: _bubble2Size,
                duration: Duration(milliseconds: 600),
                margin: EdgeInsets.only(left: 150, top: 500),
                child: Hero(
                  tag: 'bubble-2',
                  child: Bubble(size: _bubble2Size),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logoImage',
                  child: AnimatedContainer(
                    curve: Curves.bounceOut,
                    height: _logoSize,
                    width: _logoSize,
                    duration: Duration(milliseconds: 800),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 600),
                  child: _button,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
