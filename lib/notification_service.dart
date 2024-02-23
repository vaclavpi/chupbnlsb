import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Inicializace notifikací
    AwesomeNotifications().initialize(
      // Definice ikony notifikace
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
        )
      ],
    );

    // Spustíme periodické zasílání notifikací
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Poslechni si podcast!',
        body: 'Pojď si poslechnout poidcast.',
      ),
      schedule: NotificationInterval(
        interval: 60, // Interval v sekundách, zde každá minuta
      ),
    );

    return MaterialApp(
      title: 'Flutter Notification Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Notification Demo'),
        ),
        body: Center(
          child: Text(
            'Notifikace jsou spuštěny!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
