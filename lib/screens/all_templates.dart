import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widgets/bubble.dart';
import '../widgets/template.dart';
import '../widgets/menu_drawer.dart';
import '../models/bubble.dart';
import '../transitions/slide_right.dart';

class AllTemplates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          'Bubble',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      drawer: MenuDrawer(),
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
          children: <Widget>[
            Container(
              height: 120,
              child: Stack(
                children: [
                  Positioned(
                    top: 40,
                    left: 200,
                    child: Hero(
                      tag: 'logoImage',
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 60,
                        width: 60,
                        semanticLabel: 'Bubble logo',
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 20,
                    height: 40,
                    width: 40,
                    child: Hero(
                      tag: 'bubble-2',
                      child: Bubble(
                        size: 80,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 0,
                    height: 80,
                    width: 80,
                    child: Hero(
                      tag: 'bubble-1',
                      child: Bubble(
                        size: 80,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              elevation: 3,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.lightBlue[300]
                      : Colors.lightBlue[700],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Text(
                          'My Templates',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => Navigator.push(context, SlideRightRoute(page: TemplateSheet()),),
                      ),
                    ]),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: Hive.box<BubbleTask>('bubbles').listenable(),
              builder: (context, Box<BubbleTask> box, _) {
                if (box.isEmpty) {
                  return Center(
                    child: Text('No Templates'),
                  );
                }
                return Center(
                  child: Text('Template list...'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
