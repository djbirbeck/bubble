import 'dart:async';

import 'package:flutter/material.dart';

import './home_screen.dart';
import '../widgets/begin_button.dart';
import '../widgets/bubble.dart';
import '../widgets/onboarding.dart';
import '../transitions/fade.dart';

class Splash extends StatefulWidget {
  final Function switchFunction;

  const Splash({this.switchFunction});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  Future<String> permissionStatusFuture;
  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  double _logoSize;
  double _bubble1Size;
  double _bubble2Size;
  bool _visible;
  bool _allVisible;
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _logoSize = 0;
    _bubble1Size = 0;
    _bubble2Size = 0;
    _visible = false;
    _allVisible = false;
    _animateIn();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    super.initState();
  }

  void _animateIn() {
    Timer(Duration(milliseconds: 10), () {
      setState(() {
        _allVisible = !_allVisible;
      });
    });

    Timer(Duration(milliseconds: 600), () {
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
      _controller.forward();
      setState(() {
        _visible = !_visible;
      });
    });
  }

  void _animatePreTransition(String screen) {
    setState(() {
      _visible = !_visible;
    });
    _controller.reverse();
    if (screen == 'main') {
      Timer(Duration(milliseconds: 400), () {
        Navigator.pushReplacement(
          context,
          FadeRoute(
            page: HomeScreen(),
          ),
        );
      });
    } else {
      Timer(Duration(milliseconds: 400), () {
        Navigator.pushReplacement(
          context,
          FadeRoute(
            page: OnBoarding(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _allVisible ? 1.0 : 0.0,
      duration: Duration(seconds: 1),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ],
            ),
          ),
          child: Stack(
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
                        child: Image.asset('assets/images/logo.png',
                            semanticLabel: 'Bubble logo'),
                      ),
                    ),
                    FadeTransition(
                      opacity: _animation,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 600),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.cyan[100]
                                  : Colors.cyan,
                              width: _visible ? 3 : 0,
                            ),
                            borderRadius: BorderRadius.circular(32)),
                        child: BeginButton(
                          animateButtonFunction: _animatePreTransition,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
