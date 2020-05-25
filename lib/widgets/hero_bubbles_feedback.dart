import 'package:flutter/material.dart';

import './bubble.dart';

class HeroBubblesFeedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            height: 30,
            width: 30,
            right: 20,
            top: 40,
            child: Hero(
              tag: 'bubble-1',
              child: Bubble(size: 50),
            ),
          ),
          Positioned(
            left: 30,
            top: 10,
            child: Hero(
              tag: 'logoImage',
              child: Image.asset(
                'assets/images/logo.png',
                height: 80,
                width: 80,
                semanticLabel: 'Bubble logo',
              ),
            ),
          ),
          Positioned(
            height: 50,
            width: 50,
            left: 200,
            bottom: 0,
            child: Hero(
              tag: 'bubble-2',
              child: Bubble(size: 70),
            ),
          ),
        ],
      ),
    );
  }
}
