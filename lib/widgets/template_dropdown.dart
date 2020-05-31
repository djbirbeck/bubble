import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io' show Platform;

import '../models/timer_template.dart';

class TemplateDropdown extends StatefulWidget {
  final Function updateTimer;
  final TimerTemplate timerTemp;
  final bool editing;

  TemplateDropdown({this.updateTimer, this.editing, this.timerTemp});

  @override
  _TemplateDropdownState createState() => _TemplateDropdownState();
}

class _TemplateDropdownState extends State<TemplateDropdown> {
  TimerTemplate _template;
  bool _editing;
  int _iosIndex;

  @override
  void initState() {
    widget.editing == null ? _editing = false : _editing = widget.editing;
    _template = widget.timerTemp;
    _iosIndex = 0;
    super.initState();
  }

  void _cupertinoPopUp(BuildContext context, Box box) {
    if (_template == null) {
      var initialTemp = box.values.toList().elementAt(0);
      widget.updateTimer(initialTemp);
      setState(() {
        _template = initialTemp;
      });
    }
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 264,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: FlatButton(
                  child: Text(
                    'Done',
                    style: CupertinoTheme.of(context).textTheme.actionTextStyle,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Container(
                height: 216,
                color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                child: CupertinoPicker(
                  itemExtent: 32.0,
                  scrollController:
                      FixedExtentScrollController(initialItem: _iosIndex),
                  onSelectedItemChanged: (value) {
                    var templateToUse = box.values.toList().elementAt(value);
                    widget.updateTimer(templateToUse);
                    setState(() {
                      _iosIndex = value;
                      _template = templateToUse;
                    });
                  },
                  children: box.values.map((e) {
                    return Center(
                      child: Text(
                        e.title,
                        style: CupertinoTheme.of(context).textTheme.textStyle,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.lightBlue[100], width: 2),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.lightBlue[100],
                  width: 2,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.purple[50]
                        : Colors.indigo[900],
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.black,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_template == null ? 0 : _template.workTime.toString()}m',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'work',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  )
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable:
                  Hive.box<TimerTemplate>('timerTemplates').listenable(),
              builder: (context, Box<TimerTemplate> box, _) {
                if (box.isEmpty) {
                  return Center(
                    child: Text(
                      'Add Template',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  );
                }
                return Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Platform.isAndroid
                      ? ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text(
                              _template != null
                                  ? _template.title
                                  : 'Select Template',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            iconEnabledColor: Colors.white,
                            items: box.values.map((e) {
                              return DropdownMenuItem(
                                value: e.title,
                                child: Center(
                                  child: Text(
                                    e.title,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: _editing
                                ? null
                                : (value) {
                                    var templateToUse =
                                        box.values.where((element) {
                                      return element.title == value;
                                    }).single;
                                    widget.updateTimer(templateToUse);
                                    setState(() {
                                      _template = templateToUse;
                                    });
                                  },
                          ),
                        )
                      : CupertinoTheme(
                          data: CupertinoThemeData(),
                          child: CupertinoButton(
                            child: Text(
                              _template != null
                                  ? _template.title
                                  : 'Select Template',
                              style: TextStyle(
                                color: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .color,
                              ),
                            ),
                            onPressed: _editing
                                ? null
                                : () => _cupertinoPopUp(context, box),
                          ),
                        ),
                );
              },
            ),
            Container(
              height: 60,
              width: 60,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.lightBlue[100],
                  width: 2,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.purple[50]
                        : Colors.indigo[900],
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.black,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_template == null ? 0 : _template.restTime.toString()}m',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'rest',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
