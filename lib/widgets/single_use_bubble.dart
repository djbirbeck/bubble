import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quiver/async.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import './bubble_button.dart';
import '../models/completed_bubble.dart';

class SingleUseBubble extends StatefulWidget {
  @override
  _SingleUseBubbleState createState() => _SingleUseBubbleState();
}

class _SingleUseBubbleState extends State<SingleUseBubble>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _isSmallBubble;
  bool _bubbling = true;
  bool _countingDown = false;
  int _time;
  CountdownTimer _countDownTimer;
  StreamSubscription<CountdownTimer> _sub;
  Box _completedBox = Hive.box<CompletedBubble>('completedBubbles');

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    _isSmallBubble = false;
    _time = 3000;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
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
        _restCountDown(_isSmallBubble ? 300 : 600);
        var completed = CompletedBubble(
          bubbleType: _isSmallBubble ? 'small' : 'big',
          amountOfBubbles: 1,
          completedDate: DateTime.now(),
        );
        _completedBox.add(completed);
        setState(() {
          _bubbling = !_bubbling;
        });
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
        _bubbleCountDown(_isSmallBubble ? 1500 : 3000);
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
      _controller.forward();
    } else if (_countingDown && _bubbling) {
      setState(() {
        _countingDown = !_countingDown;
      });
      _sub.cancel();
      flutterLocalNotificationsPlugin.cancel(0);
      _controller.reverse();
    } else if (_countingDown && !_bubbling) {
      setState(() {
        _countingDown = !_countingDown;
      });
      _sub.cancel();
      flutterLocalNotificationsPlugin.cancel(1);
      _controller.reverse();
    } else if (!_countingDown && !_bubbling) {
      setState(() {
        _countingDown = !_countingDown;
      });
      _restCountDown(_time);
      _controller.forward();
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width * 0.7,
          width: MediaQuery.of(context).size.width * 0.7,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.lightBlue,
              width: 4,
            ),
          ),
          child: Text(
            transformSeconds(_time),
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.lightBlue,
              fontSize: 50,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _isSmallBubble = !_isSmallBubble;
              _time = _isSmallBubble ? 1500 : 3000;
            });
            if (_bubbling && _countingDown) {
              _sub.cancel();
              _bubbleCountDown(_time);
            } else if (!_bubbling && _countingDown) {
              _sub.cancel();
              _restCountDown(_time);
            }
          },
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.lightBlue[50]
                    : Colors.lightBlue,
                width: 4,
              ),
            ),
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.cyanAccent[700]
                : Colors.indigo[900],
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width * 0.7,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 60,
                    child: BubbleButton(
                      bubbleSizeMin: 20,
                      bubbleSizeMax: 40,
                      selected: _isSmallBubble == true ? true : false,
                    ),
                  ),
                  Container(
                    width: 60,
                    child: Text(
                      '${_isSmallBubble ? 'Little' : 'Big'}\nBubble',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 60,
                    child: BubbleButton(
                      bubbleSizeMin: 40,
                      bubbleSizeMax: 60,
                      selected: _isSmallBubble == false ? true : false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width * 0.2,
          width: MediaQuery.of(context).size.width * 0.2,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.lightBlue[50]
                  : Colors.lightBlue,
              width: 4,
            ),
          ),
          child: IconButton(
            iconSize: 40,
            icon: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: _controller,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.lightBlue[50]
                  : Colors.lightBlue,
            ),
            onPressed: _playPause,
          ),
        ),
      ],
    );
  }
}
