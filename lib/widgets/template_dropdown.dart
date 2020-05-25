import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  @override
  void initState() {
    widget.editing == null ? _editing = false : _editing = widget.editing;
    _template = widget.timerTemp;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
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
                    child: ButtonTheme(
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
                                  style: Theme.of(context).textTheme.headline6,
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
                                }),
                    ),
                  );
                }),
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
