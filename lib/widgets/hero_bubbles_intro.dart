import 'package:flutter/material.dart';

import './bubble.dart';

class HeroBubblesIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 40,
            child: Text(
              'Bubble',
              style: TextStyle(
                color: Theme.of(context).textTheme.headline6.color,
                fontFamily: Theme.of(context).textTheme.headline6.fontFamily,
                fontSize: 24
              ),
            ),
          ),
          Positioned(
            height: 50,
            width: 50,
            left: 60,
            bottom: 50,
            child: Hero(
              tag: 'bubble-1',
              child: Bubble(size: 50),
            ),
          ),
          Positioned(
            right: 160,
            top: 40,
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
            height: 70,
            width: 70,
            right: 40,
            top: 0,
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
