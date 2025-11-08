import 'package:flutter/material.dart';
import 'raccoon_gift.dart';
import '../settings_page.dart'; // make sure to import your SettingsPage
import '../services/coin_manager.dart';

class HomeAloneRiles extends StatelessWidget {
  const HomeAloneRiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB3E5FC),
              Color(0xFFFFE0B2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "AlzPlay",
                      style: TextStyle(
                        fontFamily: 'Jersey 10',
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.monetization_on,
                                color: Colors.orange,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              ValueListenableBuilder<int>(
                                valueListenable: CoinManager.instance.coins,
                                builder: (context, coins, child) => Text(
                                  '$coins',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsPage(),
                              ),
                            );
                          },
                          child: const Icon(Icons.menu, size: 28),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GiftCoinsPage(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/match_game/folder3/raccoon1.png',
                  height: 250,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
