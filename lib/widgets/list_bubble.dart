import 'package:Bubble/screens/new_bubble_tabs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/bubble.dart';
import '../screens/play_screen.dart';
import '../transitions/slide_right.dart';

class ListBubble extends StatelessWidget {
  final BubbleTask bubble;
  final Function deleteFunction;
  final int index;

  ListBubble({
    this.bubble,
    this.deleteFunction,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Card(
            margin: EdgeInsets.only(left: 0, top: 24, right: 0, bottom: 24),
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
                    height: 66,
                    width: 66,
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
                          bubble.bubbleType == 'small'
                              ? ((bubble.amountOfBubbles -
                                          bubble.completedBubbles) *
                                      0.5)
                                  .toString()
                              : (bubble.amountOfBubbles -
                                      bubble.completedBubbles)
                                  .toStringAsFixed(0),
                          style: TextStyle(fontSize: 24),
                        ),
                        Text('hours')
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            bubble.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          DateFormat.yMd().format(bubble.dueDate),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 72),
                ],
              ),
            ),
          ),
          Positioned(
            right: 8,
            top: 4,
            child: Semantics(
              label: 'Delete this bubble button',
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(300),
                ),
                elevation: 0,
                margin: EdgeInsets.zero,
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red[900], width: 2),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).brightness == Brightness.light
                            ? Colors.red[50]
                            : Colors.grey[900],
                        Theme.of(context).brightness == Brightness.light
                            ? Colors.redAccent[100]
                            : Theme.of(context).accentColor,
                      ],
                    ),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.red[900],
                    ),
                    onPressed: () => deleteFunction(context, bubble),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 66,
            bottom: 0,
            child: !bubble.completed
                ? Semantics(
                    label: 'Delete this bubble button',
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(300),
                      ),
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.indigoAccent[700], width: 2),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.purple[50]
                                  : Colors.grey[900],
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.indigo[200]
                                  : Theme.of(context).accentColor,
                            ],
                          ),
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.indigoAccent[700],
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            SlideRightRoute(
                              page: NewBubbleTabs(
                                bubbleInfo: bubble,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ),
          Positioned(
            left: 66,
            bottom: 0,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(300),
              ),
              elevation: 0,
              margin: EdgeInsets.zero,
              child: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: bubble.completed
                        ? Colors.green[900]
                        : Colors.amber[900],
                    width: 2,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: bubble.completed
                        ? [
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.green[100]
                                : Colors.grey[900],
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.greenAccent
                                : Theme.of(context).accentColor,
                          ]
                        : [
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.yellow[200]
                                : Colors.grey[900],
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.amberAccent
                                : Theme.of(context).accentColor,
                          ],
                  ),
                ),
                child: bubble.completed
                    ? Semantics(
                        label: 'Completed icon',
                        child: Icon(
                          Icons.check,
                          color: Colors.green[900],
                        ),
                      )
                    : Semantics(
                        label: 'Button to navigate to play screen',
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.amber[900],
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            SlideRightRoute(
                              page: PlayScreen(
                                bubbleInfo: bubble,
                                deleteFunction: deleteFunction,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
