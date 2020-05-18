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
  double _totalBubbles;
  int _time;
  bool _countingDown = false;
  bool _bubbling = true;
  CountdownTimer _countDownTimer;
  StreamSubscription<CountdownTimer> _sub;
  Widget _dateWidget = Container();
  Widget _titleWidget = Container();
  Widget _notesWidget = Container();
  Color _playColour = Colors.green[900];
  Box _completedBox = Hive.box<CompletedBubble>('completedBubbles');
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    _iconController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _totalBubbles = widget.bubbleInfo.amountOfBubbles;
    _time = widget.bubbleInfo.bubbleType == 'small' ? 1500 : 3000;
    Timer(Duration(milliseconds: 600), () {
      setState(() {
        _dateWidget = Text(
          'Due: ' + DateFormat.yMMMMd().format(widget.bubbleInfo.dueDate),
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        );
        _titleWidget = Text(
          widget.bubbleInfo.title,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        );
        _notesWidget = Text(
          widget.bubbleInfo.notes,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        );
      });
    });
    super.initState();
  }

  @override
  dispose() {
    _iconController.dispose();
    super.dispose();
  }

  void _addNotification({bool isBubble, int time}) async {
    var scheduledNotificationDateTime = DateTime.now().add(
      Duration(seconds: time),
    );
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      isBubble ? 'completedBubble' : 'completedRest',
      isBubble ? 'Completed Bubble' : 'Completed Rest',
      isBubble ? 'Bubble is complete' : 'Rest is complete',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      isBubble ? 0 : 1,
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
          bubbleType: widget.bubbleInfo.bubbleType,
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
            _playColour = Colors.green[900];
          });
        } else {
          _restCountDown(widget.bubbleInfo.bubbleType == 'small' ? 300 : 600);
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
        _bubbleCountDown(widget.bubbleInfo.bubbleType == 'small' ? 1500 : 3000);
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
        _playColour = Colors.amber[900];
      });
      _bubbleCountDown(_time);
      _iconController.forward();
    } else if (_countingDown && _bubbling) {
      setState(() {
        _countingDown = !_countingDown;
        _playColour = Colors.green[900];
      });
      _sub.cancel();
      flutterLocalNotificationsPlugin.cancel(0);
      _iconController.reverse();
    } else if (_countingDown && !_bubbling) {
      setState(() {
        _countingDown = !_countingDown;
        _playColour = Colors.green[900];
      });
      _sub.cancel();
      flutterLocalNotificationsPlugin.cancel(1);
      _iconController.reverse();
    } else if (!_countingDown && !_bubbling) {
      setState(() {
        _countingDown = !_countingDown;
        _playColour = Colors.amber[900];
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
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 120,
            child: Stack(
              children: [
                Positioned(
                  top: 40,
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
          Container(
            height: 30,
            margin: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              child: _titleWidget,
            ),
          ),
          Container(
            height: 30,
            margin: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              child: _dateWidget,
            ),
          ),
          Container(
            height: 80,
            margin: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              child: _notesWidget,
            ),
          ),
          Container(
            height: 212,
            width: 212,
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  left: 12,
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
                          width: 3,
                        ),
                      ),
                      child: Text(
                        transformSeconds(_time),
                        softWrap: true,
                        style: TextStyle(fontSize: 20),
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
                          width: 3,
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
                        child: Text(
                          _totalBubbles.toStringAsFixed(0),
                          softWrap: true,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
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
                    onPressed: () => Navigator.of(context).pop(),
                    child: Icon(Icons.arrow_back),
                    textColor: Colors.red[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Container(),
                AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _playColour,
                      width: 2,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).brightness == Brightness.light
                            ? Colors.green[50]
                            : Colors.grey[900],
                        Theme.of(context).brightness == Brightness.light
                            ? Colors.greenAccent[100]
                            : Theme.of(context).accentColor,
                      ],
                    ),
                  ),
                  child: widget.bubbleInfo.completed
                      ? Semantics(
                          label: 'completed icon',
                          child: Icon(Icons.check, color: Colors.green[900]),
                        )
                      : Semantics(
                          label: 'play or pause button',
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: _iconController,
                              color: _playColour,
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
    );
  }
}
