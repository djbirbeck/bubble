import 'package:flutter/material.dart';

import '../widgets/menu_drawer.dart';
import '../widgets/feedback.dart';
import '../widgets/hero_bubbles_feedback.dart';

class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          'Support & More',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      drawer: MenuDrawer(currentScreen: 'feedback'),
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
            HeroBubblesFeedback(),
            Expanded(
              child: FeedbackWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
