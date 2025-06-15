import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:audioplayers/audioplayers.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart, isForegroundMode: true, autoStart: true));
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // First execution immediately
  await checkPrayerTimesAndPlayAzan(service);

  // Run only once after 1 minute (for testing)
  Timer(Duration(minutes: 1), () async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
            title: "Prayer Reminder", content: "Checking prayer times");
      }
    }
    await checkPrayerTimesAndPlayAzan(service);
    service.invoke('update');
  });
}


Future<void> checkPrayerTimesAndPlayAzan(ServiceInstance service) async {
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

Future<void> playAzan() async {
  final player = AudioPlayer();
  await player.play(AssetSource('audio/azan.mp3'));
}

Future<void> showNotification(String title, String body) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'prayer_channel',
    'Prayer Notifications',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics);
}
