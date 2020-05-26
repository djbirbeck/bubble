import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class BubbleDetails extends StatefulWidget {
  final TabController tabController;
  final String titleText;
  final String notesText;
  final DateTime dueDate;
  final Function updateTitle;
  final Function updateNotes;
  final Function updateDueDate;
  final Function saveBubble;
  final double amountOfBubbles;

  const BubbleDetails({
    this.tabController,
    this.titleText,
    this.notesText,
    this.dueDate,
    this.updateTitle,
    this.updateNotes,
    this.updateDueDate,
    this.amountOfBubbles,
    this.saveBubble,
  });

  @override
  _BubbleDetailsState createState() => _BubbleDetailsState();
}

class _BubbleDetailsState extends State<BubbleDetails> {
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _selectedDate;

  @override
  void initState() {
    widget.titleText == null
        ? _titleController.text = ''
        : _titleController.text = widget.titleText;
    widget.notesText == null
        ? _notesController.text = ''
        : _notesController.text = widget.notesText;
    if (widget.dueDate != null) {
      _selectedDate = widget.dueDate;
    }
    super.initState();
  }

  void _presentDatePicker(BuildContext context) {
    if (Platform.isAndroid) {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2050),
      ).then((value) {
        if (value == null) {
          return;
        }
        widget.updateDueDate(value);
        setState(() {
          _selectedDate = value;
        });
      });
    } else if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return CupertinoTheme(
              data: CupertinoThemeData(),
              child: Container(
                color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                height: 216,
                child: CupertinoDatePicker(
                  initialDateTime:
                      _selectedDate == null ? DateTime.now() : _selectedDate,
                  onDateTimeChanged: (DateTime newDate) {
                    widget.updateDueDate(newDate);
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                  minimumYear: 2020,
                  mode: CupertinoDatePickerMode.date,
                ),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: 8,
              ),
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.lightBlue, width: 3),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ],
                ),
              ),
              child: TextField(
                cursorColor: Theme.of(context).primaryColor,
                autocorrect: false,
                maxLength: 30,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'Bubble name',
                  labelStyle: Theme.of(context).textTheme.headline6,
                  counterStyle: Theme.of(context).textTheme.headline6,
                ),
                controller: _titleController,
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
                onChanged: (value) => widget.updateTitle(value),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: 8,
              ),
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.lightBlue, width: 3),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ],
                ),
              ),
              child: TextField(
                cursorColor: Theme.of(context).primaryColor,
                autocorrect: false,
                maxLength: 160,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'Bubble details (optional)',
                  labelStyle: Theme.of(context).textTheme.headline6,
                  counterStyle: Theme.of(context).textTheme.headline6,
                ),
                controller: _notesController,
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
                onChanged: (value) => widget.updateNotes(value),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.lightBlue, width: 3),
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
                onPressed: () => _presentDatePicker(context),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _selectedDate == null
                        ? 'Choose date (optional)'
                        : '${DateFormat.yMMMEd().format(_selectedDate)}',
                    style: Theme.of(context).textTheme.headline6,
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
