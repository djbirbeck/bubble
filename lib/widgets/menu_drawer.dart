import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/statistics_screen.dart';
import '../screens/about_screen.dart';
import '../screens/all_templates.dart';
import '../screens/home_screen.dart';
import '../transitions/slide_right.dart';

class MenuDrawer extends StatelessWidget {
  final String currentScreen;

  MenuDrawer({@required this.currentScreen});

    _launch8BitBirbeck() async {
    const url = 'https://8bitbirbeck.co.uk/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _changeMainWidget(
      Widget screen, String screenName, BuildContext context) {
    if (screenName != currentScreen) {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        SlideRightRoute(
          page: screen,
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Menu'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.bubble_chart),
                  title: Text('Home'),
                  onTap: () {
                    _changeMainWidget(HomeScreen(), 'home', context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.show_chart),
                  title: Text('Your Statistics'),
                  onTap: () {
                    _changeMainWidget(
                        StatisticsScreen(), 'statistics', context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.alarm_add),
                  title: Text('My Templates'),
                  onTap: () {
                    _changeMainWidget(AllTemplates(), 'templates', context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('About Bubble'),
                  onTap: () {
                    _changeMainWidget(AboutScreen(), 'about', context);
                  },
                ),
              ],
            ),
            InkWell(
              onTap: _launch8BitBirbeck,
              child: Container(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/8bitbirbeck.png',
                      height: 40,
                      width: 40,
                    ),
                    Text(
                      '8BitBirbeck',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
