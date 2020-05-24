import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import './bubble_details.dart';
import './bubble_type.dart';
import '../models/bubble.dart';
import '../models/timer_template.dart';
import '../widgets/bubble.dart';
import '../widgets/basic_scaffold.dart';

class NewBubbleTabs extends StatefulWidget {
  final BubbleTask bubbleInfo;

  const NewBubbleTabs({this.bubbleInfo});

  @override
  _NewBubbleTabsState createState() => _NewBubbleTabsState();
}

class _NewBubbleTabsState extends State<NewBubbleTabs>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  String _title;
  String _notes;
  TimerTemplate _bubbleTemplate;
  double _amountOfBubbles;
  bool _editing;
  DateTime _dueDate;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _amountOfBubbles = 0;
    _editing = widget.bubbleInfo == null ? false : true;
    if (widget.bubbleInfo != null) {
      _title = widget.bubbleInfo.title;
      _notes = widget.bubbleInfo.notes;
      _dueDate = widget.bubbleInfo.dueDate;
      _bubbleTemplate = widget.bubbleInfo.bubbleTemplate;
      _amountOfBubbles = widget.bubbleInfo.amountOfBubbles;
    }
    super.initState();
  }

  void _updateTitle(String title) {
    setState(() {
      _title = title;
    });
  }

  void _updateNotes(String notes) {
    setState(() {
      _notes = notes;
    });
  }

  void _updateDueDate(DateTime dueDate) {
    setState(() {
      _dueDate = dueDate;
    });
  }

  void _updateBubbleTemplate(TimerTemplate bubbleTemplate) {
    setState(() {
      _bubbleTemplate = bubbleTemplate;
    });
  }

  void _addBubble() {
    setState(() {
      _amountOfBubbles = _amountOfBubbles + 1;
    });
  }

  void _minusBubble() {
    if (_amountOfBubbles <= 0) {
      return;
    } else if (widget.bubbleInfo.completedBubbles != null &&
        _amountOfBubbles <= widget.bubbleInfo.completedBubbles) {
      return;
    } else {
      setState(() {
        _amountOfBubbles = _amountOfBubbles - 1;
      });
    }
  }

  void _saveBubble(BuildContext context) {
    if (_title == null || _title == '' || _bubbleTemplate == null || _amountOfBubbles == 0) {
      String errorTitle = '';
      String errorTemplate = '';
      String errorAmount = '';
      if (_title == null || _title == '') {
        errorTitle = 'No name for your Bubble.\n';
      }
      if (_bubbleTemplate == null) {
        errorTemplate = 'No template for your Bubble.\n';
      }
      if (_amountOfBubbles == 0) {
        errorAmount = 'Amount of Bubbles is 0.';
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            title: Text(
              'Unable to save Bubble',
              style: Theme.of(context).textTheme.headline6,
            ),
            content: Text(
              errorTitle + errorTemplate + errorAmount,
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  style: Theme.of(context).textTheme.headline6,
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
    if (!_editing) {
      final bubble = BubbleTask(
        id: DateTime.now().toString(),
        title: _title.trim(),
        notes: _notes != null ? _notes.trim() : '',
        dueDate: _dueDate == null ? DateTime.now() : _dueDate,
        bubbleTemplate: _bubbleTemplate,
        amountOfBubbles: _amountOfBubbles,
        completedBubbles: 0,
        // totalTime:
        //     _bubbleType == 'small' ? _amountOfBubbles * 0.5 : _amountOfBubbles,
        completed: false,
      );
      Box<BubbleTask> contactsBox = Hive.box<BubbleTask>('bubbles');
      contactsBox.add(bubble);
      Navigator.of(context).pop();
    } else if (_editing &&
        _amountOfBubbles != widget.bubbleInfo.completedBubbles) {
      var bubble = widget.bubbleInfo;
      bubble.id = widget.bubbleInfo.id;
      bubble.title = _title.trim();
      bubble.notes = _notes;
      bubble.dueDate = _dueDate;
      bubble.bubbleTemplate = _bubbleTemplate;
      bubble.amountOfBubbles = _amountOfBubbles;
      bubble.completedBubbles = widget.bubbleInfo.completedBubbles;
      // bubble.totalTime =
      //     _bubbleType == 'small' ? _amountOfBubbles * 0.5 : _amountOfBubbles;
      bubble.completed = false;
      bubble.save();
      Navigator.of(context).pop();
    } else if (_editing &&
        _amountOfBubbles != widget.bubbleInfo.completedBubbles &&
        widget.bubbleInfo.completedBubbles > 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            title: Text(
              'Complete this Bubble?',
              style: Theme.of(context).textTheme.headline6,
            ),
            content: Text(
              'Do you want to set this Bubble as complete?',
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily:
                        Theme.of(context).textTheme.headline6.fontFamily,
                  ),
                ),
                onPressed: () {
                  var bubble = widget.bubbleInfo;
                  bubble.id = widget.bubbleInfo.id;
                  bubble.title = _title.trim();
                  bubble.notes = _notes;
                  bubble.dueDate = _dueDate;
                  bubble.bubbleTemplate = _bubbleTemplate;
                  bubble.amountOfBubbles = _amountOfBubbles;
                  bubble.completedBubbles = widget.bubbleInfo.completedBubbles;
                  // bubble.totalTime = _bubbleType == 'small'
                  //     ? _amountOfBubbles * 0.5
                  //     : _amountOfBubbles;
                  bubble.completed = true;
                  bubble.save();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  'No',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily:
                        Theme.of(context).textTheme.headline6.fontFamily,
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
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      screenTitle: '',
      implyLeading: true,
      childWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                height: 120,
                child: Stack(
                  children: [
                    Positioned(
                      right: 20,
                      top: 10,
                      child: Text(
                        '${_editing ? 'Edit' : 'New'} Bubble',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily:
                              Theme.of(context).textTheme.headline6.fontFamily,
                        ),
                      ),
                    ),
                    Positioned(
                      height: 60,
                      width: 60,
                      right: 35,
                      bottom: 20,
                      child: Hero(
                        tag: 'bubble-1',
                        child: Bubble(size: 70),
                      ),
                    ),
                    Positioned(
                      height: 40,
                      width: 40,
                      right: 180,
                      top: 10,
                      child: Hero(
                        tag: 'bubble-2',
                        child: Bubble(size: 50),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 20,
                      child: Hero(
                        tag: 'logoImage',
                        child: Image.asset('assets/images/logo.png',
                            height: 100,
                            width: 100,
                            semanticLabel: 'Bubble logo'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BubbleDetails(
                    titleText: _title,
                    notesText: _notes,
                    dueDate: _dueDate,
                    updateTitle: _updateTitle,
                    updateNotes: _updateNotes,
                    updateDueDate: _updateDueDate,
                    amountOfBubbles: _amountOfBubbles,
                    saveBubble: _saveBubble,
                  ),
                  BubbleType(
                    saveBubble: _saveBubble,
                    updateBubbleTemplate: _updateBubbleTemplate,
                    addBubble: _addBubble,
                    minusBubble: _minusBubble,
                    bubbleTemplate: _bubbleTemplate,
                    amountOfBubbles: _amountOfBubbles,
                    editing: _editing,
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
    );
  }
}
