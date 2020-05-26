import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/intro.dart';

class BeginButton extends StatelessWidget {
  final Function animateButtonFunction;

  const BeginButton({this.animateButtonFunction});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Start button',
      child: ValueListenableBuilder(
        valueListenable: Hive.box<IntroToApp>('intro').listenable(),
        builder: (context, Box<IntroToApp> box, _) {
          if (box.values.isEmpty == true) {
            return Container(
              height: 48,
              child: OutlineButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.cyan[100]
                      : Colors.cyan,
                  width: 3,
                ),
                onPressed: () => animateButtonFunction('intro'),
                child: Text(
                  'Lets begin...',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline6.color,
                      fontSize: 20,
                      fontFamily:
                          Theme.of(context).textTheme.headline6.fontFamily),
                ),
              ),
            );
          }
          return Container(
            height: 48,
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              borderSide: BorderSide(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.cyan[100]
                    : Colors.cyan,
                width: 3,
              ),
              onPressed: () => animateButtonFunction('main'),
              child: Text(
                'Lets get started...',
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline6.color,
                  fontSize: 20,
                  fontFamily: Theme.of(context).textTheme.headline6.fontFamily,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
