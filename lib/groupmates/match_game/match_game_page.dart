import 'package:flutter/material.dart';
import 'screens/how_to_play_screen.dart';
import 'services/coin_manager.dart';

class MatchGamePage extends StatefulWidget {
  const MatchGamePage({super.key});

  @override
  State<MatchGamePage> createState() => _MatchGamePageState();
}

class _MatchGamePageState extends State<MatchGamePage> {
  @override
  void initState() {
    super.initState();
    CoinManager.instance.init();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HowToPlayScreen(),
    );
  }
}

