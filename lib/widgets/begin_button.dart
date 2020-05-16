import 'package:flutter/material.dart';

class BeginButton extends StatelessWidget {
  final Function animateButtonFunction;

  const BeginButton({this.animateButtonFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: animateButtonFunction,
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
}
