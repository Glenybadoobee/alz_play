import 'dart:math';
import 'package:flutter/material.dart';
import '../raccoon/home_alone_riles.dart';
import '../settings_page.dart';
import '../services/coin_manager.dart';

class GameLevel1Screen extends StatefulWidget {
  const GameLevel1Screen({super.key});

  @override
  State<GameLevel1Screen> createState() => _GameLevel1ScreenState();
}

class _GameLevel1ScreenState extends State<GameLevel1Screen> {
  bool _awardedCoins = false;

  late List<String> _images;
  late List<bool> _revealed;
  late List<int> _flippedIndexes;
  bool _gameFinished = false;

  @override
  void initState() {
    super.initState();
    _images = [
      'assets/match_game/level1/burger.png',
      'assets/match_game/level1/burger.png',
      'assets/match_game/level1/lemon.png',
      'assets/match_game/level1/lemon.png',
      'assets/match_game/level1/hamster.png',
      'assets/match_game/level1/hamster.png',
    ]..shuffle();

    _revealed = List.filled(_images.length, false);
    _flippedIndexes = [];
  }

  void _onCardTap(int index) {
    if (_revealed[index] ||
        _flippedIndexes.length == 2 ||
        _flippedIndexes.contains(index)) {
      return;
    }

    setState(() {
      _flippedIndexes.add(index);
    });

    if (_flippedIndexes.length == 2) {
      final first = _flippedIndexes[0];
      final second = _flippedIndexes[1];

      if (_images[first] == _images[second]) {
        setState(() {
          _revealed[first] = true;
          _revealed[second] = true;
          _flippedIndexes.clear();
        });

        if (_revealed.every((r) => r)) {
          setState(() {
            _gameFinished = true;
          });


          if (!_awardedCoins) {
            CoinManager.instance.addCoins(10);
            _awardedCoins = true;
          }
        }
      } else {
        Future.delayed(const Duration(milliseconds: 700), () {
          setState(() {
            _flippedIndexes.clear();
          });
        });
      }
    }
  }

  bool _isFlipped(int index) {
    return _revealed[index] || _flippedIndexes.contains(index);
  }

  Widget _buildCardFace({
    required Key key,
    required bool isFront,
    required String imagePath,
  }) {
    const double borderRadius = 20.0;
    const double borderThickness = 3.0;

    return Container(
      key: key,
      decoration: BoxDecoration(
        color: isFront ? Colors.white : const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.black, width: borderThickness),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius - 5),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
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
            colors: [Color(0xFFB3E7FF), Color(0xFFFFE1A8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  // 🔹 HEADER
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SettingsPage(),
                                  ),
                                );
                              },
                              child: const Icon(Icons.menu,
                                  size: 34, color: Colors.black),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF56B9E0),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.black, width: 2),
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
                                        // Live coin display
                                        ValueListenableBuilder<int>(
                                          valueListenable:
                                              CoinManager.instance.coins,
                                          builder: (context, coins, child) =>
                                              Text(
                                            "$coins",
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
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF53A653),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                      border: Border(
                                        left: BorderSide(
                                            color: Colors.black, width: 2),
                                      ),
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

                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF53A653),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 2.5),
                    ),
                    child: const Text(
                      "LEVEL 1",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8DC0FF),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: AspectRatio(
                        aspectRatio: 2 / 3.0,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1,
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
                                      final isBack =
                                          (ValueKey(_isFlipped(index)) !=
                                              child?.key);
                                      final value = isBack
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
                                child: _isFlipped(index)
                                    ? _buildCardFace(
                                        key: const ValueKey(true),
                                        isFront: true,
                                        imagePath: _images[index],
                                      )
                                    : _buildCardFace(
                                        key: const ValueKey(false),
                                        isFront: false,
                                        imagePath: 'assets/match_game/level1/question.png',
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // 🔹 BUTTONS
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Back
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB3E7FF),
                              foregroundColor: Colors.black,
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

                        // Next → HomeAloneRiles
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _gameFinished
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeAloneRiles(),
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _gameFinished
                                  ? const Color(0xFF53A653)
                                  : const Color(0xFFB3E7FF).withAlpha(128),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                    color: Colors.black, width: 2),
                              ),
                              elevation: _gameFinished ? 4 : 0,
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
