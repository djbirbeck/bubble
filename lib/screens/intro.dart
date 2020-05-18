import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../widgets/hero_bubbles_intro.dart';
import '../widgets/help.dart';
import '../screens/home_screen.dart';
import '../transitions/fade.dart';
import '../models/intro.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Bubble',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
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
              Text(
                'Welcome to Bubble!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).textTheme.headline6.color,
                    fontSize: 24,
                    fontFamily:
                        Theme.of(context).textTheme.headline6.fontFamily),
              ),
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
                              'Let\'s Go!',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            onPressed: () {
                              Box<IntroToApp> introBox =
                                  Hive.box<IntroToApp>('intro');
                              var intro = IntroToApp(introCompleted: true);
                              introBox.add(intro);
                              Navigator.pushReplacement(
                                context,
                                FadeRoute(
                                  page: HomeScreen(),
                                ),
                              );
                            }),
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
