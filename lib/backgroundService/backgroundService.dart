import 'dart:async';
import 'package:workmanager/workmanager.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:audioplayers/audioplayers.dart';

const prayerTask = "prayerTask";

class BackgroundService {
  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      if (task == prayerTask) {
        await checkPrayerTimesAndPlayAzan();
      }
      return Future.value(true);
    });
  }

  static Future<void> checkPrayerTimesAndPlayAzan() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      PrayerCalculationParameters params = PrayerCalculationMethod.karachi();
      params.madhab = PrayerMadhab.hanafi;

      PrayerTimes prayerTimes = PrayerTimes(
        coordinates: Coordinates(position.latitude, position.longitude),
        calculationParameters: params,
        precision: true,
        locationName: 'Asia/Kolkata',
      );

      List<DateTime> prayerTimesList = [
        prayerTimes.fajrStartTime!,
        prayerTimes.dhuhrStartTime!,
        prayerTimes.asrStartTime!,
        prayerTimes.maghribStartTime!,
        prayerTimes.ishaStartTime!,
      ];

      DateTime now = DateTime.now();

      playAzan();
      showNotification("Prayer Time", "It's time for Salah!");
      for (DateTime prayerTime in prayerTimesList) {
        if (now.hour == prayerTime.hour && now.minute == prayerTime.minute) {
          playAzan();
          showNotification("Prayer Time", "It's time for Salah!");
        }
      }
    } catch (e) {
      print("Error in background task: $e");
    }
  }

  static Future<void> playAzan() async {
    final player = AudioPlayer();
    await player.play(AssetSource('audio/azan.mp3'));
  }

  static Future<void> showNotification(String title, String body) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'prayer_channel',
      'Prayer Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics);
  }

  static void registerService() {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    Workmanager().registerPeriodicTask(
      "1",
      prayerTask,
      frequency: Duration(seconds: 3), // Runs every 15 minutes
    );
  }
}
