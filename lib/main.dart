import 'package:duabook/controller/initController.dart';
import 'package:duabook/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'backgroundService/back_service.dart';
import 'backgroundService/backgroundService.dart';
import 'controller/localization.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // LocationPermission permission = await Geolocator.requestPermission();
  // if (permission != LocationPermission.denied && permission != LocationPermission.deniedForever) {
  //   BackgroundService.registerService();
  // }
  // await initializeService();

  await FlutterDownloader.initialize(
      debug: true
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Khushi Dua Book',
      initialBinding: InitControllers(),
      debugShowCheckedModeBanner: false,
      translations: Localization(),
      locale: Locale("english","US"),
      home: Dashboard(),
    );
  }
}
