import 'dart:math';
import 'package:flutter/material.dart';
import 'raccoon_page.dart';
import '../settings_page.dart';
import '../services/coin_manager.dart';

class MoneyRaccoon extends StatefulWidget {
  const MoneyRaccoon({super.key});

  @override
  State<MoneyRaccoon> createState() => _MoneyRaccoonState();
}

class _MoneyRaccoonState extends State<MoneyRaccoon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final int _coinCount = 8;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 🪙 Build animated falling coins
  Widget _buildPoppingCoin(int index, Size size) {
    final double startX = _random.nextDouble() * size.width;
    final double delay = _random.nextDouble();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double progress = (_controller.value + delay) % 1.0;

        // Coins start near the top (yPos = -50) and fall down the screen.
        final double yPos = (progress * size.height * 1.1) - 50;

        // Coins fade in near the top and fade out near the bottom
        final double opacity =
            progress < 0.1 ? progress * 10 : (1.0 - progress);

        return Positioned(
          left: startX,
          top: yPos,
          child: Opacity(
            opacity: opacity,
            child: Transform.scale(
              scale: 0.8 + (progress * 0.4),
              child: Image.asset(
                'assets/match_game/folder8/coin.png',
                width: 40,
                height: 40,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onRaccoonTap() async {
    // Raccoon touch animation (pop effect)
    setState(() => _scale = 1.2);
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() => _scale = 1.0);
    await Future.delayed(const Duration(milliseconds: 150));

    if (!mounted) return;
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => const RaccoonPage(),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFABE7FF), Color(0xFFFFE1A8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // 🪙 Falling coins
            ...List.generate(
                _coinCount, (index) => _buildPoppingCoin(index, size)),

            // 🧩 Header section (AlzPlay, Menu, Coins)
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AlzPlay',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),

                    // ☰ Menu on top, Coins below
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsPage()),
                            );
                          },
                          child: const Icon(Icons.menu,
                              size: 32, color: Colors.black87),
                        ),
                        const SizedBox(height: 10),

                        // 💰 Coin Box
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF7ED6FC),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: Row(
                                  children: [
                                    const Icon(Icons.monetization_on,
                                        color: Colors.amber, size: 22),
                                    const SizedBox(width: 4),
                                    ValueListenableBuilder<int>(
                                      valueListenable:
                                          CoinManager.instance.coins,
                                      builder: (context, coins, child) => Text(
                                        '$coins',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                ),
                                child: const Icon(Icons.add,
                                    color: Colors.white, size: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 🦝 Raccoon and Trophy Section (Fixed Position)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: GestureDetector(
                  onTap: _onRaccoonTap,
                  child: AnimatedScale(
                    scale: _scale,
                    duration: const Duration(milliseconds: 150),
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none, // ✅ prevents cropping
                      children: [
                        // 🦝 Raccoon (behind)
                        Image.asset(
                          'assets/folder4/raccoon2.png',
                          width: 210,
                          height: 230,
                        ),

                        // 🏆 Trophy (in front, fixed position)
                        Positioned(
                          left: -35, // slight left for perfect hold
                          bottom: 95, // lower so it sits near paw
                          child: Transform.rotate(
                            angle: -0.18, // less tilt for realism
                            child: Image.asset(
                              'assets/folder7/trophy.png',
                              width: 140,
                              height: 140,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
