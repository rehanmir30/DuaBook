import 'package:flutter/material.dart';

class PremiumSettings extends StatefulWidget {
  const PremiumSettings({super.key});

  @override
  State<PremiumSettings> createState() => _PremiumSettingsState();
}

class _PremiumSettingsState extends State<PremiumSettings> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Premium"),
    );
  }
}
