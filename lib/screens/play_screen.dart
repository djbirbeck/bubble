import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:quiver/async.dart';

import '../models/bubble.dart';
import '../models/completed_bubble.dart';
import '../widgets/bubble.dart';
import '../widgets/basic_scaffold.dart';
import '../widgets/template_list_item.dart';

class PlayScreen extends StatefulWidget {
  final BubbleTask bubbleInfo;
  final Function deleteFunction;
  final Function animateTransition;

  const PlayScreen(
      {this.bubbleInfo, this.deleteFunction, this.animateTransition});

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> with TickerProviderStateMixin {
  AnimationController _iconController;
  Animation<Color> _colourAnimation;
  double _totalBubbles;
  int _time;
  bool _countingDown = false;
  bool _bubbling = true;
  CountdownTimer _countDownTimer;
  StreamSubscription<CountdownTimer> _sub;
  var _lines = List<String>();
  Box _completedBox = Hive.box<CompletedBubble>('completedBubbles');
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    _iconController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _colourAnimation = ColorTween(
      begin: Colors.lightGreenAccent[100],
      end: Colors.amber[700],
    ).animate(_iconController)
      ..addListener(() {
        setState(() {});
      });
    _totalBubbles =
        widget.bubbleInfo.amountOfBubbles - widget.bubbleInfo.completedBubbles;
    _time = widget.bubbleInfo.bubbleTemplate.workTime * 60;
    super.initState();
  }

  @override
  dispose() {
    flutterLocalNotificationsPlugin.cancelAll();
    _iconController.dispose();
    super.dispose();
  }

  void _addNotification({bool isBubble, int time}) async {
    var scheduledNotificationDateTime = DateTime.now().add(
      Duration(seconds: time),
    );

    _lines.add(isBubble ? 'Time to chill!' : 'Back to work!');

    var inboxStyleInformation = InboxStyleInformation(
      _lines,
      contentTitle: 'Lots of Bubbling going on here!',
    );
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'bubble-channel',
      'bubble-channel',
      'bubble-notifications',
      groupKey: 'com.eightbitbirbeck.bubble.bubbles',
      styleInformation: inboxStyleInformation,
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      1,
      isBubble ? 'Bubble complete' : 'Rest over',
      isBubble ? 'Time to chill!' : 'Back to work!',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
  }

  void _bubbleCountDown(int time) async {
    var _timeOutInSeconds = time - 1;
    const _stepInSeconds = 1;
    int _currentNumber = 0;
    _addNotification(isBubble: true, time: time);

    _countDownTimer = new CountdownTimer(
      Duration(seconds: time),
      Duration(seconds: 1),
    );
    _sub = _countDownTimer.listen(null);

    _sub.onData((duration) {
      _currentNumber += _stepInSeconds;
      int _countdownNumber = _timeOutInSeconds - _currentNumber;
      // Make it start from the timeout value
      _countdownNumber += _stepInSeconds;
      if (_countdownNumber == 0) {
        _sub.cancel();
        var completed = CompletedBubble(
          bubbleTemplate: widget.bubbleInfo.bubbleTemplate,
          amountOfBubbles: 1,
          completedDate: DateTime.now(),
        );
        _completedBox.add(completed);
        var bubble = widget.bubbleInfo;
        bubble.completedBubbles = bubble.completedBubbles + 1;
        bubble.save();
        setState(() {
          _bubbling = !_bubbling;
          _totalBubbles -= 1;
        });
        if (_totalBubbles == 0) {
          var bubble = widget.bubbleInfo;
          bubble.completed = true;
          bubble.save();
          _time = 0;
          setState(() {
            _iconController.reverse();
          });
        } else {
          _restCountDown(widget.bubbleInfo.bubbleTemplate.restTime * 60);
        }
      }
      setState(() {
        _time = _countdownNumber;
      });
    });
  }

  void _restCountDown(int time) {
    var _timeOutInSeconds = time - 1;
    const _stepInSeconds = 1;
    int _currentNumber = 0;
    _addNotification(isBubble: false, time: time);

    _countDownTimer = new CountdownTimer(
      Duration(seconds: time),
      Duration(seconds: 1),
    );
    _sub = _countDownTimer.listen(null);

    _sub.onData((duration) {
      _currentNumber += _stepInSeconds;
      int _countdownNumber = _timeOutInSeconds - _currentNumber;
      // Make it start from the timeout value
      _countdownNumber += _stepInSeconds;
      if (_countdownNumber == 0) {
        _sub.cancel();
        _bubbleCountDown(widget.bubbleInfo.bubbleTemplate.workTime * 60);
        setState(() {
          _bubbling = !_bubbling;
        });
      }
      setState(() {
        _time = _countdownNumber;
      });
    });
  }

  void _playPause() {
    if (!_countingDown && _bubbling) {
      setState(() {
        _countingDown = !_countingDown;
      });
      _bubbleCountDown(_time);
      _iconController.forward();
    } else if (_countingDown && _bubbling) {
      setState(() {
        _countingDown = !_countingDown;
      });
      _sub.cancel();
      flutterLocalNotificationsPlugin.cancelAll();
      _iconController.reverse();
    } else if (_countingDown && !_bubbling) {
      setState(() {
        _countingDown = !_countingDown;
      });
      _sub.cancel();
      flutterLocalNotificationsPlugin.cancelAll();
      _iconController.reverse();
    } else if (!_countingDown && !_bubbling) {
      setState(() {
        _countingDown = !_countingDown;
      });
      _restCountDown(_time);
      _iconController.forward();
    }
  }

  transformSeconds(int seconds) {
    //Thanks to Andrew
    //int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hoursStr == '00' && minutesStr == '00') {
      return '00:' + secondsStr;
    } else if (hoursStr == '00') {
      return minutesStr + ':' + secondsStr;
    } else {
      return hoursStr + ':' + minutesStr + ':' + secondsStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      screenTitle: widget.bubbleInfo.title,
      implyLeading: true,
      childWidget: SafeArea(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 120,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 200,
                    child: Hero(
                      tag: 'logoImage',
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 60,
                        width: 60,
                        semanticLabel: 'Bubble logo',
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 20,
                    height: 40,
                    width: 40,
                    child: Hero(
                      tag: 'bubble-2',
                      child: Bubble(
                        size: 80,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 0,
                    height: 80,
                    width: 80,
                    child: Hero(
                      tag: 'bubble-1',
                      child: Bubble(
                        size: 80,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 30,
                    alignment: Alignment.center,
                    child: Text(
                      'Due: ' +
                          DateFormat.yMMMMd().format(widget.bubbleInfo.dueDate),
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily:
                            Theme.of(context).textTheme.headline6.fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.9,
                    alignment: Alignment.center,
                    child: Text(
                      widget.bubbleInfo.notes,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily:
                            Theme.of(context).textTheme.headline6.fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TemplateListItem(
                    timerTemplate: widget.bubbleInfo.bubbleTemplate,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 230,
                        width: 230,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 30,
                              left: 30,
                              height: 200,
                              width: 200,
                              child: Hero(
                                tag: 'bubble-3',
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 4,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        transformSeconds(_time),
                                        style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.white
                                              : Colors.lightBlue,
                                          fontSize: 50,
                                          fontFamily: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .fontFamily,
                                        ),
                                      ),
                                      Text(
                                        _bubbling ? 'Working' : 'Resting',
                                        style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.white
                                              : Colors.lightBlue,
                                          fontSize: 18,
                                          fontFamily: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .fontFamily,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              height: 100,
                              width: 100,
                              top: 0,
                              left: 0,
                              child: Hero(
                                tag: 'amount-bubble',
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 4,
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Theme.of(context).primaryColor,
                                        Theme.of(context).accentColor,
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          _totalBubbles.toStringAsFixed(0),
                                          softWrap: true,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .fontFamily,
                                          ),
                                        ),
                                        Text(_totalBubbles != 1
                                            ? 'Bubbles'
                                            : 'Bubble')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(),
                        Container(),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.15,
                          width: MediaQuery.of(context).size.width * 0.15,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _colourAnimation.value,
                              width: 4,
                            ),
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: _totalBubbles == 0
                                ? Icon(
                                    Icons.check,
                                    color: _colourAnimation.value,
                                  )
                                : IconButton(
                                    iconSize: 40,
                                    icon: AnimatedIcon(
                                      semanticLabel: 'Play or pause button',
                                      icon: AnimatedIcons.play_pause,
                                      progress: _iconController,
                                      color: _colourAnimation.value,
                                    ),
                                    onPressed: _playPause,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
