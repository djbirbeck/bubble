import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import './bubble_details.dart';
import './bubble_type.dart';
import '../models/bubble.dart';
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
  DateTime _dueDate;
  String _bubbleType;
  double _amountOfBubbles;

  bool _editing;

  Widget _rightButton;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _amountOfBubbles = 0;
    _rightButton = Text('Next');
    _editing = widget.bubbleInfo == null ? false : true;
    if (widget.bubbleInfo != null) {
      _title = widget.bubbleInfo.title;
      _notes = widget.bubbleInfo.notes;
      _dueDate = widget.bubbleInfo.dueDate;
      _bubbleType = widget.bubbleInfo.bubbleType;
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

  void _updateBubbleType(String bubbleType) {
    setState(() {
      _bubbleType = bubbleType;
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
    } else {
      setState(() {
        _amountOfBubbles = _amountOfBubbles - 1;
      });
    }
  }

  void _saveBubble(BuildContext context) {
    if (_title == null || _bubbleType == null || _amountOfBubbles == 0) {
      String errorTitle = '';
      String errorType = '';
      String errorAmount = '';
      if (_title == null) {
        errorTitle = 'No name for your Bubble.\n';
      }
      if (_bubbleType == null) {
        errorType = 'Bubble size not selected.\n';
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
            title: Text('Unable to save Bubble'),
            content: Text(errorTitle + errorType + errorAmount),
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
        bubbleType: _bubbleType,
        amountOfBubbles: _amountOfBubbles,
        completedBubbles: 0,
        totalTime:
            _bubbleType == 'small' ? _amountOfBubbles * 0.5 : _amountOfBubbles,
        completed: false,
      );
      Box<BubbleTask> contactsBox = Hive.box<BubbleTask>('bubbles');
      contactsBox.add(bubble);
      Navigator.of(context).pop();
    } else {
      var bubble = widget.bubbleInfo;
      bubble.id = widget.bubbleInfo.id;
      bubble.title = _title.trim();
      bubble.notes = _notes;
      bubble.dueDate = _dueDate;
      bubble.bubbleType = _bubbleType;
      bubble.amountOfBubbles = _amountOfBubbles;
      bubble.completedBubbles = widget.bubbleInfo.completedBubbles;
      bubble.totalTime =
          _bubbleType == 'small' ? _amountOfBubbles * 0.5 : _amountOfBubbles;
      bubble.completed = false;
      bubble.save();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      childWidget: Column(
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
                      'New Bubble',
                      style: TextStyle(fontSize: 24),
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
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                BubbleDetails(
                  tabController: _tabController,
                  titleText: _title,
                  notesText: _notes,
                  dueDate: _dueDate,
                  updateTitle: _updateTitle,
                  updateNotes: _updateNotes,
                  updateDueDate: _updateDueDate,
                ),
                BubbleType(
                  tabController: _tabController,
                  saveBubble: _saveBubble,
                  updateBubbleType: _updateBubbleType,
                  addBubble: _addBubble,
                  minusBubble: _minusBubble,
                  bubbleType: _bubbleType,
                  amountOfBubbles: _amountOfBubbles,
                  editing: _editing,
                ),
              ],
            ),
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
                color: Theme.of(context).primaryColor,
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Text('Back'),
                          onPressed: () {
                            _tabController.index == 0
                                ? Navigator.pop(context)
                                : setState(
                                    () {
                                      _tabController.index =
                                          _tabController.index--;
                                      _rightButton = Text('Next');
                                    },
                                  );
                          },
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
                color: Theme.of(context).primaryColor,
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 600),
                            child: _rightButton,
                          ),
                          onPressed: () {
                            _tabController.index == 0
                                ? setState(() {
                                    _tabController.index =
                                        _tabController.index++;
                                    _rightButton = Text('Save');
                                  })
                                : _saveBubble(context);
                          },
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
