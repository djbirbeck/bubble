import 'package:flutter/material.dart';

import '../widgets/hero_bubbles.dart';
import '../widgets/today_stats.dart';
import '../widgets/bubble_list.dart';
import '../widgets/single_use_bubble.dart';
import '../widgets/statistics.dart';
import '../widgets/help.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('Bubble'),
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
              HeroBubbles(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    TodayStats(),
                    SingleUseBubble(),
                    BubbleList(),
                    Statistics(),
                    ListView(
                      children: <Widget>[
                        Text('About Bubble', style: TextStyle(fontSize: 24), textAlign: TextAlign.center,),
                        Help(),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TabPageSelector(
                  controller: _tabController,
                  color: Colors.indigo,
                  selectedColor: Colors.lightBlue[50],
                  indicatorSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
