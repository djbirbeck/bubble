import 'package:flutter/material.dart';

import '../transitions/slide_right.dart';
import './basic_scaffold.dart';
import './statistics.dart';
import './help.dart';

class MenuDrawer extends StatelessWidget {

  void _navigateTo({Widget screen, BuildContext context, String title}) {
    Navigator.pop(context);
    Navigator.push(
      context,
      SlideRightRoute(
        page: BasicScaffold(childWidget: screen, implyLeading: true, screenTitle: title,),
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
              onTap: () => _navigateTo(screen: Statistics(), context: context, title: 'Your Statistics'),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About BUbble'),
              onTap: () => _navigateTo(screen: Help(), context: context, title: 'About Bubble'),
            ),
          ],
        ),
      ),
    );
  }
}
