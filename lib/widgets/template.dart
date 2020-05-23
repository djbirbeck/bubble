import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import './basic_scaffold.dart';

class TemplateSheet extends StatefulWidget {
  @override
  _TemplateSheetState createState() => _TemplateSheetState();
}

class _TemplateSheetState extends State<TemplateSheet> {
  final _titleController = TextEditingController();
  int _workTime;
  int _restTime;
  String _title;

  @override
  void initState() {
    _workTime = 5;
    _restTime = 5;
    _title = '';
    super.initState();
  }

  void _saveTemplate() {
    print('w: $_workTime, r: $_restTime, t: $_title');
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      screenTitle: 'New Template',
      implyLeading: true,
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
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
              decoration: InputDecoration(
                labelText: 'Template name',
                labelStyle: Theme.of(context).textTheme.headline6,
                counterStyle: Theme.of(context).textTheme.headline6,
              ),
              controller: _titleController,
              onSubmitted: (_) => FocusScope.of(context).unfocus(),
              onChanged: (value) {
                setState(() {
                  _title = value;
                });
              },
            ),
          ),
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  size: MediaQuery.of(context).size.width * 0.5,
                  startAngle: 140,
                  angleRange: 260,
                  customColors: CustomSliderColors(
                    trackColor: Colors.blue,
                    hideShadow: true,
                    progressBarColors: [
                      Colors.indigo,
                      Colors.blue[600],
                      Colors.cyan[300],
                    ],
                  ),
                ),
                min: 5,
                max: 90,
                initialValue: 5,
                innerWidget: (double value) {
                  final roundedValue = value.ceil().toInt().toString();
                  return Center(
                    child: Container(
                      child: Text(
                        '${roundedValue}m\nwork',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline6.color,
                          fontFamily:
                              Theme.of(context).textTheme.headline6.fontFamily,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                },
                onChangeEnd: (value) {
                  setState(() {
                    _workTime = value.ceil().toInt();
                  });
                },
              ),
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  size: MediaQuery.of(context).size.width * 0.35,
                  startAngle: 140,
                  angleRange: 260,
                  customColors: CustomSliderColors(
                    trackColor: Colors.blue,
                    hideShadow: true,
                    progressBarColors: [
                      Colors.indigo,
                      Colors.blue[600],
                      Colors.cyan[300],
                    ],
                  ),
                ),
                min: 5,
                max: 30,
                initialValue: 5,
                innerWidget: (double value) {
                  final roundedValue = value.ceil().toInt().toString();
                  return Center(
                    child: Container(
                      child: Text(
                        '${roundedValue}m\nrest',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline6.color,
                          fontFamily:
                              Theme.of(context).textTheme.headline6.fontFamily,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                },
                onChangeEnd: (value) {
                  setState(() {
                    _workTime = value.ceil().toInt();
                  });
                },
              ),
          Container(
            height: 66,
            width: MediaQuery.of(context).size.width * 0.4,
            margin: EdgeInsets.symmetric(vertical: 16),
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
                          child: Text(
                            'Save',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        onPressed: _saveTemplate,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
