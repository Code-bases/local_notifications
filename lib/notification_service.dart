import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }
  // ? Instance spécifique de notification pour Android et iOS
  static const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('channel id', 'channel name',
          icon: 'ic_stat_access_alarm',
          largeIcon: DrawableResourceAndroidBitmap('ic_stat_access_alarm'),
          importance: Importance.high,
          priority: Priority.max);
  static const IOSNotificationDetails iOSPlatformChannelSpecifics =
      IOSNotificationDetails();

  // ? Variable qui adapte les paramètres de notification en fonction de la plateforme utilisée
  static const NotificationDetails platformChannelSpecifics =
      NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  NotificationService._internal();

  // ? Fonction à appeler au début du programme
  Future<void> init() async {
    // ? Paramètres d'initialisation (paramètres par défaut)
    // ? Icone par défaut pour Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_stat_access_alarm');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    // ? Variable qui applique les paramètres par défaut en fonction de la
    // ? Plateforme utilisée
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    // ? Initialisation
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    // ? Logique appelée lorsuqe l'on appuie sur la notification
  }

  // ? Envoyer une notification normale
  Future<void> showNotification() async {
    await flutterLocalNotificationsPlugin.show(
      12345,
      "A Notification From My Application",
      "This notification was sent using Flutter Local Notifcations Package",
      platformChannelSpecifics,
    );
  }

  // ? Envoyer une notification programmée
  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(const Duration(seconds: 4));
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
}
