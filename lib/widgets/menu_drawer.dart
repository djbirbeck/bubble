import 'package:flutter/material.dart';

import '../transitions/slide_right.dart';
import '../screens/statistics_screen.dart';
import '../screens/help_screen.dart';
import '../screens/all_templates.dart';

class MenuDrawer extends StatelessWidget {
  void _navigateTo({Widget screen, BuildContext context}) {
    Navigator.pop(context);
    Navigator.push(
      context,
      SlideRightRoute(
        page: screen,
      ),
    );
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.bubble_chart),
              title: Text('Your Statistics'),
              onTap: () => _navigateTo(
                screen: StatisticsScreen(),
                context: context,
              ),
            ),
            ListTile(
              leading: Icon(Icons.alarm_add),
              title: Text('My Templates'),
              onTap: () => _navigateTo(
                screen: AllTemplates(),
                context: context,
              ),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About Bubble'),
              onTap: () => _navigateTo(
                screen: HelpScreen(),
                context: context,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
