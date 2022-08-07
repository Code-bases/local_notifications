// ? Source : https://www.freecodecamp.org/news/local-notifications-in-flutter/

import 'dart:async';

import 'package:flutter/material.dart';

import 'notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationService notificationService = NotificationService();
  await notificationService.init();
  // ! Trouver un autre moyen d'utiliser notification service partout dans l'application
  // ! Plutôt que par un passage en paramètre mais plutôt avec provider
  runApp(MyApp(notificationService: notificationService));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.notificationService}) : super(key: key);

  final NotificationService notificationService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      title: 'Flutter notification example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter notification example'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Show notification'),
                onPressed: () {
                  notificationService.showNotification();
                },
              ),
              ElevatedButton(
                child: const Text('Schedule notification'),
                onPressed: () {
                  notificationService.scheduleNotification();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
