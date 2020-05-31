import 'package:flutter/material.dart';

import '../models/timer_template.dart';
import '../widgets/template_dropdown.dart';
import '../widgets/template.dart';
import '../transitions/slide_right.dart';

class BubbleType extends StatelessWidget {
  final Function saveBubble;
  final Function updateBubbleTemplate;
  final Function addBubble;
  final Function minusBubble;
  final TimerTemplate bubbleTemplate;
  final double amountOfBubbles;
  final bool editing;
  final int bubblesComplete;

  BubbleType(
      {this.saveBubble,
      this.updateBubbleTemplate,
      this.addBubble,
      this.minusBubble,
      this.bubbleTemplate,
      this.amountOfBubbles,
      this.editing,
      this.bubblesComplete});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TemplateDropdown(
                updateTimer: updateBubbleTemplate,
                editing: editing,
                timerTemp: bubbleTemplate,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.cyan[100]
                        : Colors.cyan,
                    width: 3,
                  ),
                  child: Text(
                    'Add new Template',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  onPressed: () => Navigator.push(
                              context,
                              SlideRightRoute(page: TemplateSheet()),
                            ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlue, width: 3),
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'How many Bubbles?',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Semantics(
                          label: 'minus button',
                          child: FloatingActionButton(
                            heroTag: 'minusFAB',
                            backgroundColor: Colors.lightBlueAccent[400],
                            elevation: 3,
                            mini: true,
                            child: Icon(Icons.remove),
                            onPressed: () => minusBubble(),
                          ),
                        ),
                        Container(
                          width: 100,
                          alignment: Alignment.center,
                          child: Text(
                            amountOfBubbles.toStringAsFixed(0),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .fontFamily,
                            ),
                          ),
                        ),
                        Semantics(
                          label: 'add button',
                          child: FloatingActionButton(
                            heroTag: 'addFAB',
                            backgroundColor: Colors.lightBlueAccent[400],
                            elevation: 3,
                            mini: true,
                            child: Icon(Icons.add),
                            onPressed: () => addBubble(),
                          ),
                        ),
                      ],
                    ),
                    !editing
                        ? Container()
                        : Text(
                            '$bubblesComplete ${bubblesComplete == 1 ? 'Bubble' : 'Bubbles'} completed',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 66,
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.3),
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
                      onPressed: () => saveBubble(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
