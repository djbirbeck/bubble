import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import './screens/splash.dart';
import './models/bubble.dart';
import './models/completed_bubble.dart';
import './models/intro.dart';
import './widgets/basic_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(BubbleTaskAdapter());
  Hive.registerAdapter(CompletedBubbleAdapter());
  Hive.registerAdapter(IntroAdapter());
  Hive.openBox<CompletedBubble>('completedBubbles');
  Hive.openBox<Intro>('intro');
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
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.cyan[50],
        accentColor: Colors.lightBlue[400],
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
        appBarTheme: AppBarTheme(
          color: Colors.cyan[50],
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  color: Colors.lightBlue[800],
                  fontSize: 20
                ),
              ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.blue[900],
        accentColor: Colors.black,
        brightness: Brightness.dark,
        textTheme: ThemeData.dark().textTheme.copyWith(
              headline6: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.grey[50],
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.dark().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 20,
                  color: Colors.lightBlue[50],
                ),
              ),
        ),
      ),
      title: 'Bubble',
      home: FutureBuilder(
        future: Hive.openBox<BubbleTask>('bubbles'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Splash();
            }
          } else
            return BasicScaffold();
        },
      ),
    );
  }
}
