import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io' show Platform;

import './list_bubble.dart';
import '../models/bubble.dart';
import '../screens/new_bubble_tabs.dart';
import '../transitions/slide_right.dart';

class BubbleList extends StatefulWidget {
  @override
  _BubbleListState createState() => _BubbleListState();
}

class _BubbleListState extends State<BubbleList> {
  String _search;
  int _iosIndex;

  @override
  void initState() {
    _search = 'All';
    _iosIndex = 0;
    super.initState();
  }

  void _deleteTransaction(BuildContext context, BubbleTask bubble) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (Platform.isAndroid) {
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
                  "Keep",
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily:
                        Theme.of(context).textTheme.headline6.fontFamily,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily:
                        Theme.of(context).textTheme.headline6.fontFamily,
                  ),
                ),
                onPressed: () {
                  bubble.delete();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
        return CupertinoTheme(
          data: CupertinoThemeData(),
          child: CupertinoAlertDialog(
            title: Text(
              'Delete this bubble?',
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Delete'),
                isDestructiveAction: true,
                onPressed: () {
                  bubble.delete();
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text('Keep'),
                isDefaultAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
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
        centerTitle: false,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        actions: [
          ButtonBar(children: [
            Platform.isAndroid
                ? DropdownButton(
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
                    })
                : CupertinoTheme(
                    data: CupertinoThemeData(),
                    child: CupertinoButton(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          _search,
                          style: TextStyle(
                            color: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .color,
                          ),
                        ),
                        onPressed: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 216,
                                  color: CupertinoTheme.of(context)
                                      .scaffoldBackgroundColor,
                                  child: CupertinoPicker(
                                    itemExtent: 32.0,
                                    scrollController:
                                        FixedExtentScrollController(
                                            initialItem: _iosIndex),
                                    onSelectedItemChanged: (int value) {
                                      String searchValue;
                                      switch (value) {
                                        case 0:
                                          searchValue = 'All';
                                          break;
                                        case 1:
                                          searchValue = 'Today';
                                          break;
                                        case 2:
                                          searchValue = 'Complete';
                                          break;
                                        case 3:
                                          searchValue = 'Incomplete';
                                          break;
                                        default:
                                          searchValue = 'All';
                                          break;
                                      }
                                      setState(() {
                                        _search = searchValue;
                                        _iosIndex = value;
                                      });
                                    },
                                    children: [
                                      Center(
                                        child: Text(
                                          'All',
                                          style: CupertinoTheme.of(context)
                                              .textTheme
                                              .textStyle,
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          'Today',
                                          style: CupertinoTheme.of(context)
                                              .textTheme
                                              .textStyle,
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          'Complete',
                                          style: CupertinoTheme.of(context)
                                              .textTheme
                                              .textStyle,
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          'Incomplete',
                                          style: CupertinoTheme.of(context)
                                              .textTheme
                                              .textStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }),
                  ),
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
            )
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
                  onPressed: () => Navigator.push(
                    context,
                    SlideRightRoute(
                      page: NewBubbleTabs(),
                    ),
                  ),
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
