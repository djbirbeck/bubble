import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../transitions/slide_right.dart';
import '../screens/home_screen.dart';

class OnBoarding extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =  FlutterLocalNotificationsPlugin();

  final pageList = [
    PageModel(
      color: Colors.cyan,
      heroAssetPath: 'assets/images/logo.png',
      title: Text(
        'Bubble',
        style: TextStyle(
          fontSize: 34,
          color: Colors.white,
          fontFamily: 'Josefin Sans',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Bubble is a focus timer and planner that aims to help you organise your time and be as productive as you feel you need to be.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'Josefin Sans',
          ),
        ),
      ),
      iconAssetPath: 'assets/images/logo.png',
    ),
    PageModel(
      color: Colors.lightBlue,
      heroAssetPath: 'assets/images/circle_check.png',
      title: Text(
        'To-do or not To-do...',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 34.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Create a to-do list or set a timer on the go.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
      iconAssetPath: 'assets/images/circle_check.png',
    ),
    PageModel(
      color: Colors.blue,
      heroAssetPath: 'assets/images/timer.png',
      title: Text(
        'Templates',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 34.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Use one of the two preset timer templates or create your own.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
      iconAssetPath: 'assets/images/timer.png',
    ),
    PageModel(
      color: Colors.indigo,
      heroAssetPath: 'assets/images/notification.png',
      title: Text(
        'Notifications',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 34.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Bubble will need to be able to send you notifications, this is so you know when your Bubble or rest time is complete.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
      iconAssetPath: 'assets/images/notification.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FancyOnBoarding(
        doneButtonText: "Done",
        skipButtonText: "Skip",
        pageList: pageList,
        doneButtonBackgroundColor: Colors.indigo,
        onDoneButtonPressed: () {
          flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
          Navigator.pushReplacement(
            context,
            SlideRightRoute(
              page: HomeScreen(),
            ),
          );
        },
        onSkipButtonPressed: () {
          flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
          Navigator.pushReplacement(
            context,
            SlideRightRoute(
              page: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
