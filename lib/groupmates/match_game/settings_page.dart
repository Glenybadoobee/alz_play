import 'package:flutter/material.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF56B9E0),
      ),
      body: const Center(
        child: Text("Settings Content Here"),
      ),
    );
  }
}