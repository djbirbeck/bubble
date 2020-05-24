import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../widgets/hero_bubbles_intro.dart';
import '../widgets/help.dart';
import '../screens/home_screen.dart';
import '../transitions/fade.dart';
import '../models/intro.dart';
import '../models/timer_template.dart';

class Intro extends StatelessWidget {
  void _navigateHome(BuildContext context) {
    Box<TimerTemplate> templatesBox = Hive.box<TimerTemplate>('timerTemplates');
    Box<IntroToApp> introBox = Hive.box<IntroToApp>('intro');
    var smallTemplate = TimerTemplate(
      title: 'Small Bubble',
      workTime: 25,
      restTime: 5,
    );
    var bigTemplate = TimerTemplate(
      title: 'Big Bubble',
      workTime: 50,
      restTime: 10,
    );

    templatesBox.add(smallTemplate);
    templatesBox.add(bigTemplate);

    var intro = IntroToApp(introCompleted: true);
    introBox.add(intro);

    Navigator.pushReplacement(
      context,
      FadeRoute(
        page: HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
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
        child: Center(
          child: Column(
            children: <Widget>[
              HeroBubblesIntro(),
              Expanded(
                child: ListView(
                  children: [
                    Help(),
                    Container(
                      height: 66,
                      margin: EdgeInsets.all(16),
                      child: Card(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        elevation: 3,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Text(
                            'Get in your Bubble',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          onPressed: () => _navigateHome(context),
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
