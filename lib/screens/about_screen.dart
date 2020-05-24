import 'package:flutter/material.dart';

import '../widgets/menu_drawer.dart';
import '../widgets/help.dart';
import '../widgets/hero_bubbles_help.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          'About Bubble',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      drawer: MenuDrawer(currentScreen: 'about'),
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
        child: Column(
          children: [
            HeroBubblesHelp(),
            Container(
              height: MediaQuery.of(context).size.height * 0.72,
              child: ListView(
                children: [
                  Help(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
