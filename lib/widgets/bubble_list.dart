import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './list_bubble.dart';
import '../models/bubble.dart';
import '../transitions/slide_right.dart';
import '../screens/new_bubble_tabs.dart';

class BubbleList extends StatefulWidget {
  @override
  _BubbleListState createState() => _BubbleListState();
}

class _BubbleListState extends State<BubbleList> {
  String _search;

  @override
  void initState() {
    _search = 'All';
    super.initState();
  }

  void _deleteTransaction(BuildContext context, BubbleTask bubble) {
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
                bubble.delete();
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[700],
        automaticallyImplyLeading: false,
        title: Text(
          'My Bubbles',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        actions: <Widget>[
          DropdownButton(
              hint: Text(
                _search,
                style: TextStyle(color: Colors.white),
              ),
              iconEnabledColor: Colors.white,
              items: [
                DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                DropdownMenuItem(
                  value: 'Today',
                  child: Text('Today'),
                ),
                DropdownMenuItem(
                  value: 'Complete',
                  child: Text('Complete'),
                ),
                DropdownMenuItem(
                  value: 'Incomplete',
                  child: Text('Incomplete'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _search = value;
                });
              }),
          Semantics(
            label: 'Add a new bubble button',
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(
                context,
                SlideRightRoute(
                  page: NewBubbleTabs(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<BubbleTask>('bubbles').listenable(),
        builder: (context, Box<BubbleTask> box, _) {
          if (box.isEmpty) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.lightBlue, width: 2),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                  ),
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
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
          var bubbleList;
          switch (_search) {
            case 'All':
              bubbleList = box.values.toList().reversed;
              break;
            case 'Today':
              bubbleList = box.values
                  .where((element) {
                    final today = DateTime.now();
                    return element.dueDate.day == today.day &&
                        element.dueDate.month == today.month &&
                        element.dueDate.year == today.year;
                  })
                  .toList()
                  .reversed;
              break;
            case 'Complete':
              bubbleList = box.values
                  .where((element) {
                    return element.completed == true;
                  })
                  .toList()
                  .reversed;
              break;
            case 'Incomplete':
              bubbleList = box.values
                  .where((element) {
                    return element.completed == false;
                  })
                  .toList()
                  .reversed;
              break;
            default:
              bubbleList = box.values.toList().reversed;
          }
          return ListView.custom(
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListBubble(
                  bubble: bubbleList.elementAt(index),
                  index: index,
                  deleteFunction: _deleteTransaction,
                );
              },
              childCount: bubbleList.length,
            ),
          );
        },
      ),
    );
  }
}
