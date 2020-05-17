import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/intro.dart';

class BeginButton extends StatelessWidget {
  final Function animateButtonFunction;

  const BeginButton({this.animateButtonFunction});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Intro>('intro').listenable(),
      builder: (context, Box<Intro> box, _) {
        if (box.values.isEmpty) {
          return Container(
            height: 30,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () => animateButtonFunction('intro'),
              child: Text(
                'Lets get started...',
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline6.color,
                  fontSize: 20,
                ),
              ),
            ),
          );
        }
        return Container(
          height: 30,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: () => animateButtonFunction('main'),
            child: Text(
              'Lets get started...',
              style: TextStyle(
                color: Theme.of(context).textTheme.headline6.color,
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}
