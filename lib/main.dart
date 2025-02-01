import 'package:duabook/controller/initController.dart';
import 'package:duabook/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
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
      home: Dashboard(),
    );
  }
}
