import 'package:Bubble/screens/new_bubble_tabs.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widgets/list_bubble.dart';
import '../models/bubble.dart';
import '../transitions/slide_right.dart';

class ListAll extends StatelessWidget {
  final Box box = Hive.box<BubbleTask>('bubbles');

  void _deleteTransaction(int id, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          title: Text('Delete this bubble?'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                box.deleteAt(id);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Keep",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.cyan[50],
            Colors.cyan[50],
            Colors.blue[400],
          ],
        ),
      ),
      child: ValueListenableBuilder(
        valueListenable: Hive.box<BubbleTask>('bubbles').listenable(),
        builder: (context, Box<BubbleTask> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black, width: 2),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.cyan[50],
                      Colors.blue[200],
                    ],
                  ),
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  onPressed: () => Navigator.push(
                    context,
                    SlideRightRoute(
                      page: NewBubbleTabs(),
                    ),
                  ),
                  child: Text('Add a Bubble?'),
                ),
              ),
            );
          }
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.cyan[50],
                //elevation: 0,
                automaticallyImplyLeading: true,
                centerTitle: true,
                title: Text('My Bubbles'),
                //elevation: 3,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => Navigator.push(
                      context,
                      SlideRightRoute(
                        page: NewBubbleTabs(),
                      ),
                    ),
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    BubbleTask currentBubble = box.getAt(index);
                    return ListBubble(
                      bubble: currentBubble,
                      index: index,
                      //addFunction: _addBubble,
                      deleteFunction: _deleteTransaction,
                      //animateTransition: _animateToInfo,
                    );
                  },
                  childCount: box.values.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
