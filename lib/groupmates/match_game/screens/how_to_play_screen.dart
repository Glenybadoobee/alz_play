import 'package:flutter/material.dart';
import 'game_level1_screen.dart';
import '../settings_page.dart';
import '../services/coin_manager.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFABE7FF),
              Color(0xFFFFE1A8),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'AlzPlay',
                          style: TextStyle(
                            fontFamily: 'Jersey 10',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsPage()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.menu,
                                  size: 34,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),

                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF56B9E0),
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 2),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.monetization_on,
                                            color: Colors.yellow, size: 24),
                                        const SizedBox(width: 4),
                                        ValueListenableBuilder<int>(
                                          valueListenable:
                                              CoinManager.instance.coins,
                                          builder: (context, coins, child) =>
                                              Text(
                                            '$coins',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
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
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                    ),
                                    child: const Icon(Icons.add,
                                        color: Colors.white, size: 26),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text(
                              'How to Play',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0A72B2),
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(color: Colors.black, width: 2),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/match_game/folder1/rabbit.png',
                                          width: 80, height: 80),
                                      const SizedBox(width: 10),
                                      const Icon(Icons.check,
                                          color: Colors.green, size: 60),
                                      const SizedBox(width: 10),
                                      Image.asset('assets/match_game/folder1/rabbit.png',
                                          width: 80, height: 80),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/match_game/folder1/rabbit.png',
                                          width: 80, height: 80),
                                      const SizedBox(width: 10),
                                      const Icon(Icons.close,
                                          color: Colors.red, size: 60),
                                      const SizedBox(width: 10),
                                      Image.asset('assets/match_game/folder2/beaver.png',
                                          width: 80, height: 80),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Tap one card to see the picture, then tap another card to find its match. '
                                    'Keep matching the pictures until all pairs are found.\n\n'
                                    'Take your time and enjoy playing!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        height: 1.5,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFABE7FF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 12),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Back',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFABE7FF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 12),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const GameLevel1Screen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
