import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './list_bubble.dart';
import '../models/bubble.dart';
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
          title: Text(
            'Delete this bubble?',
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Delete",
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: Theme.of(context).textTheme.headline6.fontFamily,
                ),
              ),
              onPressed: () {
                bubble.delete();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Keep",
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: Theme.of(context).textTheme.headline6.fontFamily,
                ),
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

  void _showBottomSheet(context) {
    showDialog(
        context: context,
        // backgroundColor: Colors.transparent,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(32),
        //     topRight: Radius.circular(32),
        //   ),
        // ),
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).accentColor,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.9,
              child: NewBubbleTabs(),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Save',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.lightBlue[300]
            : Colors.lightBlue[700],
        automaticallyImplyLeading: false,
        title: Text(
          'My Bubbles',
          style: Theme.of(context).textTheme.headline6,
        ),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        actions: [
          ButtonBar(children: [
            DropdownButton(
                hint: Text(
                  _search,
                  style: Theme.of(context).textTheme.headline6,
                ),
                iconEnabledColor: Colors.white,
                items: [
                  DropdownMenuItem(
                    value: 'All',
                    child: Text(
                      'All',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Today',
                    child: Text(
                      'Today',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Complete',
                    child: Text(
                      'Complete',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Incomplete',
                    child: Text(
                      'Incomplete',
                      style: Theme.of(context).textTheme.headline6,
                    ),
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
                onPressed: () => _showBottomSheet(context),
              ),
            ),
          ])
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
                  onPressed: () => _showBottomSheet(context),
                  child: Text(
                    'Add a Bubble?',
                    style: Theme.of(context).textTheme.headline6,
                  ),
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
