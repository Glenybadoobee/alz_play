import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../MCDO/cute_raccoon.dart';
import '../settings_page.dart';
import '../services/coin_manager.dart';

class GameLevel3Screen extends StatefulWidget {
  const GameLevel3Screen({super.key});

  @override
  State<GameLevel3Screen> createState() => _GameLevel3ScreenState();
}

class _GameLevel3ScreenState extends State<GameLevel3Screen> {
  final List<String> _images = [
    'assets/match_game/level3/happy.png',
    'assets/match_game/level3/siomai.png',
    'assets/match_game/level3/tweet.png',
    'assets/match_game/level3/pineapple.png',
    'assets/match_game/level3/angry.png',
  ];

  late List<String> _cards;
  late List<bool> _revealed;
  Map<String, int> _cardCounts = {};
  Map<String, int> _revealedCounts = {};
  bool _allMatched = false;
  bool _awardedCoins = false;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _cards = [
      ...List.filled(3, _images[3]),
      ...List.filled(3, _images[2]),
      ...List.filled(2, _images[0]),
      ...List.filled(2, _images[1]),
      ...List.filled(2, _images[4]),
    ]..shuffle();

    _cardCounts = {};
    for (var card in _cards) {
      _cardCounts[card] = (_cardCounts[card] ?? 0) + 1;
    }

    _revealed = List.generate(_cards.length, (_) => false);
    _revealedCounts = {};
    _allMatched = false;
  }

  void _onCardTap(int index) {
    if (_revealed[index]) return;

    setState(() {
      _revealed[index] = true;
      String type = _cards[index];
      _revealedCounts[type] = (_revealedCounts[type] ?? 0) + 1;

      Timer(const Duration(seconds: 1), () {
        setState(() {
          for (int i = 0; i < _cards.length; i++) {
            String t = _cards[i];
            if (t != type && _revealedCounts[t] != _cardCounts[t]) {
              _revealed[i] = false;
              _revealedCounts[t] = 0;
            }
          }
        });
      });

      _allMatched = _revealed.every((e) => e);

      if (_allMatched && !_awardedCoins) {
        CoinManager.instance.addCoins(10);
        _awardedCoins = true;
      }
    });
  }

  bool _isVisible(int index) {
    return _revealed[index];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardSize = screenWidth / 4 - 20;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFABE7FF), Color(0xFFFFE1A8)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "AlzPlay",
                          style: TextStyle(
                            fontFamily: 'Jersey 10',
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.black,
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
                              child: const Icon(Icons.menu,
                                  size: 34, color: Colors.black),
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
                                            color: Colors.yellow, size: 22),
                                        const SizedBox(width: 4),
                                        ValueListenableBuilder<int>(
                                          valueListenable:
                                              CoinManager.instance.coins,
                                          builder: (context, coins, child) =>
                                              Text(
                                            '$coins',
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
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
                                        color: Colors.white, size: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2.5),
                    ),
                    child: const Text(
                      "LEVEL 3",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFABD8FF),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _cards.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _onCardTap(index),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                transitionBuilder: (child, animation) {
                                  final rotate = Tween(begin: pi, end: 0.0)
                                      .animate(animation);
                                  return AnimatedBuilder(
                                    animation: rotate,
                                    child: child,
                                    builder: (context, child) {
                                      final isUnder =
                                          (ValueKey(_isVisible(index)) !=
                                              child?.key);
                                      final value = isUnder
                                          ? min(rotate.value, pi / 2)
                                          : rotate.value;
                                      return Transform(
                                        transform: Matrix4.rotationY(value),
                                        alignment: Alignment.center,
                                        child: child,
                                      );
                                    },
                                  );
                                },
                                child: _isVisible(index)
                                    ? Container(
                                        key: ValueKey(_cards[index]),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                        ),
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.asset(
                                              _cards[index],
                                              width: cardSize,
                                              height: cardSize,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        key: ValueKey('hidden_$index'),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                        ),
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.asset(
                                              'assets/match_game/level3/question.png',
                                              width: cardSize * 0.6,
                                              height: cardSize * 0.6,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB3E5FC),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Back",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _allMatched
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CuteRaccoon()),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB3E5FC),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Next",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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
