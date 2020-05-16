import 'package:flutter/material.dart';

import '../widgets/bubble.dart';
import '../widgets/basic_scaffold.dart';

class BubbleSummary extends StatelessWidget {
  final TabController tabController;

  BubbleSummary({this.tabController});

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      childWidget: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  left: 30,
                  bottom: 60,
                  child: Text(
                    'Your Bubble\nSummary',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.end,
                  ),
                ),
                Positioned(
                  height: 60,
                  width: 60,
                  left: 160,
                  top: 0,
                  child: Hero(
                    tag: 'bubble-1',
                    child: Bubble(size: 70),
                  ),
                ),
                Positioned(
                  height: 120,
                  width: 120,
                  left: -90,
                  top: 00,
                  child: Hero(
                    tag: 'bubble-2',
                    child: Bubble(size: 50),
                  ),
                ),
                Positioned(
                  right: 60,
                  top: 60,
                  child: Hero(
                    tag: 'logoImage',
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Bubble Title'),
              Text('Bubble Deatils'),
              Text('Date of Bubble'),
              Text('Bubble size'),
              Text('Hours of Bubbling'),
            ],
          ),
        ],
      ),
      bottomWidget: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 66,
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.only(left: 16),
              child: Card(
                margin: EdgeInsets.only(
                  bottom: 16,
                  right: 0,
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                elevation: 4,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: FlatButton(
                          child: Text('Back'),
                          onPressed: () =>
                              tabController.index = tabController.index--,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 66,
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.only(right: 16),
              child: Card(
                margin: EdgeInsets.only(
                  bottom: 16,
                  right: 0,
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                elevation: 4,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: FlatButton(
                          child: Text('Save'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
