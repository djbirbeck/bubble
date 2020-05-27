import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import './screens/splash.dart';
import './models/bubble.dart';
import './models/completed_bubble.dart';
import './models/intro.dart';
import './models/timer_template.dart';
import './widgets/basic_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(BubbleTaskAdapter());
  Hive.registerAdapter(CompletedBubbleAdapter());
  Hive.registerAdapter(IntroToAppAdapter());
  Hive.registerAdapter(TimerTemplateAdapter());
  Hive.openBox<CompletedBubble>('completedBubbles');
  Hive.openBox<IntroToApp>('intro');
  Hive.openBox<TimerTemplate>('timerTemplates');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('notification_icon');
    var initializationSettingsIOS = new IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.cyan[50],
        accentColor: Colors.lightBlue,
        canvasColor: Colors.lightBlue,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline5: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 24,
                color: Colors.grey[800],
                fontFamily: 'Josefin Sans',
              ),
              headline6: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.grey[800],
                fontFamily: 'Josefin Sans',
              ),
            ),
        appBarTheme: AppBarTheme(
          color: Colors.cyan[50],
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    color: Colors.lightBlue[800],
                    fontSize: 20,
                    fontFamily: 'Josefin Sans'),
              ),
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: CupertinoColors.white,
            textTheme: CupertinoTextThemeData(),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.blue[900],
        accentColor: Colors.black,
        brightness: Brightness.dark,
        canvasColor: Colors.black,
        textTheme: ThemeData.dark().textTheme.copyWith(
              headline5: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 24,
                color: Colors.grey[50],
                fontFamily: 'Josefin Sans',
              ),
              headline6: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.grey[50],
                fontFamily: 'Josefin Sans',
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.dark().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 20,
                  color: Colors.lightBlue[50],
                  fontFamily: 'Josefin Sans',
                ),
              ),
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: CupertinoColors.systemGrey6,
            textTheme: CupertinoTextThemeData(),
            ),
      ),
      title: 'Bubble',
      home: FutureBuilder(
        future: Hive.openBox<BubbleTask>('bubbles'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(
                snapshot.error.toString(),
                style: Theme.of(context).textTheme.headline6,
              );
            } else {
              return Splash();
            }
          } else
            return BasicScaffold(
              screenTitle: '',
              implyLeading: false,
            );
        },
      ),
    );
  }
}
