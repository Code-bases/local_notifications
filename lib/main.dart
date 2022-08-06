import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    appBarTheme: const AppBarTheme(
      color: Colors.amber,
    ),),
  home: const MyApp(),
  debugShowCheckedModeBanner: false,
));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('ic_stat_access_alarm');
    var initializationSettingsIOs = const IOSInitializationSettings();
    var initSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String? payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return NewScreen(
        payload: payload!,
      );
    }));
    return Future(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Flutter notification demo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ButtonTheme(
              minWidth: 250.0,
              child: ElevatedButton(
                onPressed: showNotification,
                child: const Text(
                  'showNotification',
                ),
              ),
            ),
            ButtonTheme(
              minWidth: 250.0,
              child: ElevatedButton(
                onPressed: scheduleNotification,
                child: const Text(
                  'scheduleNotification',
                ),
              ),
            ),
            ButtonTheme(
              minWidth: 250.0,
              child: ElevatedButton(
                onPressed: showBigPictureNotification,
                child: const Text(
                  'showBigPictureNotification',
                ),
              ),
            ),
            ButtonTheme(
              minWidth: 250.0,
              child: ElevatedButton(
                onPressed: showNotificationMediaStyle,
                child: const Text(
                  'showNotificationMediaStyle',
                ),
              ),
            ),
            ButtonTheme(
              minWidth: 250.0,
              child: ElevatedButton(
                onPressed: cancelNotification,
                child: const Text(
                  'cancelNotification',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showNotification() async {
    var android = const AndroidNotificationDetails(
        'id', 'channel ', channelDescription: 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
        payload: 'Welcome to the Local Notification demo ');
  }

  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
    DateTime.now().add(const Duration(seconds: 4));
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      icon: 'ic_stat_access_alarm',
      largeIcon: DrawableResourceAndroidBitmap('ic_stat_access_alarm'),
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future<void> showBigPictureNotification() async {
    var bigPictureStyleInformation = const BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("ic_stat_access_alarm"),
        largeIcon: DrawableResourceAndroidBitmap("ic_stat_access_alarm"),
        contentTitle: 'flutter devs',
        htmlFormatContentTitle: true,
        summaryText: 'summaryText',
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel id',
        'big text channel name',
        channelDescription: 'big text channel description',
        styleInformation: bigPictureStyleInformation);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics,
        payload: "big image notifications");
  }

  Future<void> showNotificationMediaStyle() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      channelDescription: 'media channel description',
      color: Colors.blue,
      enableLights: true,
      largeIcon: DrawableResourceAndroidBitmap("ic_stat_access_alarm"),
      styleInformation: MediaStyleInformation(),
    );
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'notification title', 'notification body', platformChannelSpecifics,payload: "show Notification Media Style");
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}

class NewScreen extends StatelessWidget {
  final String payload;

  const NewScreen({Key? key,
    required this.payload
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(payload),
      ),
    );
  }
}