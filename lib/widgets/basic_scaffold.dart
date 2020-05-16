import 'package:flutter/material.dart';

class BasicScaffold extends StatelessWidget {
  final Widget childWidget;
  final Widget bottomWidget;
  final bool extendScaffoldBody;

  BasicScaffold({this.childWidget, this.bottomWidget, this.extendScaffoldBody});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      extendBody: true,
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
        child: childWidget,
      ),
      bottomNavigationBar: bottomWidget,
    );
  }
}
