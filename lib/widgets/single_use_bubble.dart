import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quiver/async.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/completed_bubble.dart';
import '../models/timer_template.dart';
import '../widgets/template_dropdown.dart';

class SingleUseBubble extends StatefulWidget {
  @override
  _SingleUseBubbleState createState() => _SingleUseBubbleState();
}

class _SingleUseBubbleState extends State<SingleUseBubble>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colourAnimation;
  bool _bubbling = true;
  bool _countingDown = false;
  int _time;
  var _lines = List<String>();
  TimerTemplate _template;
  CountdownTimer _countDownTimer;
  StreamSubscription<CountdownTimer> _sub;
  Box _completedBox = Hive.box<CompletedBubble>('completedBubbles');

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    _time = 0;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _colourAnimation = ColorTween(
      begin: Colors.green,
      end: Colors.amber,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  dispose() {
    flutterLocalNotificationsPlugin.cancelAll();
    _controller.dispose();
    super.dispose();
  }

  void _updateTimer(TimerTemplate temp) {
    setState(() {
      _template = temp;
      _time = temp.workTime * 60;
    });
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
        _restCountDown(_template.restTime * 60);
        var completed = CompletedBubble(
          bubbleTemplate: _template,
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
        _bubbleCountDown(_template.workTime * 60);
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
    if (_template != null) {
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
        Text('Bubble on the go', style: Theme.of(context).textTheme.headline6),
        Container(
          height: MediaQuery.of(context).size.width * 0.5,
          width: MediaQuery.of(context).size.width * 0.5,
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
                fontFamily: Theme.of(context).textTheme.headline6.fontFamily),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TemplateDropdown(updateTimer: _updateTimer),
        ),
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
            child: IconButton(
              iconSize: 40,
              icon: AnimatedIcon(
                semanticLabel: 'Play or pause button',
                icon: AnimatedIcons.play_pause,
                progress: _controller,
                color: _colourAnimation.value,
              ),
              onPressed: _playPause,
            ),
          ),
        ),
      ],
    );
  }
}
