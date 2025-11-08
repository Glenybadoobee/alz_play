import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../New/stand_raccoon.dart';
import '../settings_page.dart';
import '../services/coin_manager.dart';

class GameLevel2Screen extends StatefulWidget {
  const GameLevel2Screen({super.key});

  @override
  State<GameLevel2Screen> createState() => _GameLevel2ScreenState();
}

class _GameLevel2ScreenState extends State<GameLevel2Screen> {
  final List<String> _images = const [
    'assets/match_game/level2/cakes.png',
    'assets/match_game/level2/burger.png',
    'assets/match_game/level2/moshi.png',
    'assets/match_game/level2/price.png',
  ];

  late final Map<String, Color> _cardBackgroundColors;
  late List<String> _cards;
  late List<bool> _revealed;
  Map<String, int> _cardCounts = {};
  Map<String, int> _revealedCounts = {};
  bool _allMatched = false;
  bool _awardedCoins = false;

  @override
  void initState() {
    super.initState();
    _cardBackgroundColors = {
      _images[0]: const Color(0xFF8DC0FF),
      _images[1]: Colors.white,
      _images[2]: const Color(0xFF90EE90),
      _images[3]: const Color(0xFF20B2AA),
    };
    _startGame();
  }

  void _startGame() {
    _cards = [];
    _cards.addAll([_images[0], _images[0]]);
    _cards.addAll([_images[1], _images[1]]);
    _cards.addAll([_images[2], _images[2], _images[2]]);
    _cards.addAll([_images[3], _images[3]]);
    _cards.shuffle();


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

  Widget _buildCardFace({
    required Key key,
    required bool isFront,
    required String imagePath,
  }) {
    Color cardBgColor = Colors.white;
    if (isFront) {
      cardBgColor = _cardBackgroundColors[imagePath] ?? Colors.white;
    } else {
      cardBgColor = const Color(0xFFE0E0E0);
    }

    return Container(
      key: key,
      padding: isFront ? const EdgeInsets.all(5) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black, width: 2),
      ),
      clipBehavior: Clip.hardEdge,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Center(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB3E7FF), Color(0xFFFFE1A8)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "AlzPlay",
                              style: TextStyle(
                                fontFamily: 'Jersey 10',
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF56B9E0),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.monetization_on,
                                            color: Color(0xFFFFD700), size: 24),
                                        const SizedBox(width: 4),
                                        ValueListenableBuilder<int>(
                                          valueListenable:
                                              CoinManager.instance.coins,
                                          builder: (context, coins, child) =>
                                              Text(
                                            '$coins',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(Icons.add,
                                        color: Colors.white, size: 20),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
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
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF53A653),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black, width: 2.5),
                          ),
                          child: const Text(
                            "LEVEL 2",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Game cards
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8DC0FF),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: GridView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: _cards.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.0,
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
                                    ? _buildCardFace(
                                        key: ValueKey(_cards[index]),
                                        isFront: true,
                                        imagePath: _cards[index],
                                      )
                                    : _buildCardFace(
                                        key: ValueKey("back$index"),
                                        isFront: false,
                                        imagePath: 'assets/match_game/level2/question.png',
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // Back & Next Buttons
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB3E7FF),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                    color: Colors.black, width: 2),
                              ),
                              elevation: 4,
                            ),
                            child: const Text(
                              "Back",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _allMatched
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const StandingRaccoon(),
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB3E7FF),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                    color: Colors.black, width: 2),
                              ),
                              elevation: 4,
                            ),
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
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
