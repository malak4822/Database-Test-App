import 'package:flutter/material.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.settings, size: 50),
    );
  }
}
