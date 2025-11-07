import 'dart:math';
import 'package:flutter/material.dart';
import 'package:alz_play/gamee/widgets/settings_page.dart';
import 'package:alz_play/gamee/services/coin_service.dart';
import '/widgets/top_bar.dart';
import '/Game/game_page.dart';

class GiftCoins extends StatefulWidget {
  const GiftCoins({super.key});

  @override
  State<GiftCoins> createState() => _GiftCoinsState();
}

class _GiftCoinsState extends State<GiftCoins>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final int coinCount = 8;
  double _scale = 1.0;

  // Adjustable raccoon size and alignment
  double raccoonSize = 300;
  Alignment raccoonAlignment = const Alignment(0, 1);

  int coins = 0; // current coin value

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _loadCoins();
  }

  Future<void> _loadCoins() async {
    final currentCoins = await CoinService.getCoins();
    if (mounted) {
      setState(() {
        coins = currentCoins;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFallingCoin(int index, Size size) {
    final double startX = _random.nextDouble() * size.width;
    final double delay = _random.nextDouble();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double progress = (_controller.value + delay) % 1.0;
        final double yPos = progress * size.height;
        return Positioned(
          left: startX,
          top: yPos - 50,
          child: Opacity(
            opacity: 1.0 - progress,
            child: Image.asset(
              'assets/folder1/coin.png',
              width: 40,
              height: 40,
            ),
          ),
        );
      },
    );
  }

  Future<void> _goToNextPage() async {
    setState(() => _scale = 1.2);
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() => _scale = 1.0);
    await Future.delayed(const Duration(milliseconds: 150));

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const GamePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: _goToNextPage, // Tap anywhere to continue
        child: Stack(
          children: [
            /// 🌈 Background Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFABE7FF), Color(0xFFFFE1A8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            /// 💰 Falling Coins
            ...List.generate(coinCount, (index) => _buildFallingCoin(index, size)),

            /// 🧠 Top Bar (same style as Level8Screen)
            TopBar(
              onMenuPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
              coins: coins,
            ),

            /// 🦝 Raccoon Image
            Align(
              alignment: raccoonAlignment,
              child: AnimatedScale(
                scale: _scale,
                duration: const Duration(milliseconds: 150),
                child: Image.asset(
                  'assets/folder1/racoon.png',
                  width: raccoonSize,
                  height: raccoonSize,
                ),
              ),
            ),

            /// 📝 “Tap anywhere to continue” — centered
            Align(
              alignment: const Alignment(0, 0.05),
              child: const Text(
                'Tap anywhere to continue',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
