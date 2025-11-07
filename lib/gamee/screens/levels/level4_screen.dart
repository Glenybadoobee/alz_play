import 'package:flutter/material.dart';
import 'package:alz_play/gamee/widgets/settings_page.dart';
import 'package:alz_play/gamee/services/coin_service.dart';
import 'package:alz_play/widgets/top_bar.dart';
import '/Game/game_page.dart';
import 'level0_screen.dart';

class Level4Screen extends StatefulWidget {
  const Level4Screen({super.key});

  @override
  State<Level4Screen> createState() => _Level4ScreenState();
}

class _Level4ScreenState extends State<Level4Screen> {
  String selectedAnswer = '';
  bool isAnswered = false;
  int coins = 0;

  final correctAnswer = 'Chicken nuggets';
  final List<String> options = [
    'French fries',
    'Chicken nuggets',
    'Fried chicken',
    'Spaghetti',
    'Carbonara'
  ];

  @override
  void initState() {
    super.initState();
    _loadCoins();
  }

  Future<void> _loadCoins() async {
    final currentCoins = await CoinService.getCoins();
    setState(() {
      coins = currentCoins;
    });
  }

  void checkAnswer(String answer) async {
    if (isAnswered) return;
    setState(() {
      selectedAnswer = answer;
      isAnswered = true;
    });

    Future.delayed(const Duration(seconds: 1), () async {
      if (!mounted) return;
      if (answer == correctAnswer) {
        await CoinService.addCoins(10);
        await _loadCoins();

        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Level0Animated()),
        );
      } else {
        setState(() {
          selectedAnswer = '';
          isAnswered = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFABE7FF), Color(0xFFFFE1A8)],
              ),
            ),
          ),

          TopBar(
            onMenuPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
            coins: coins,
          ),

          Align(
            alignment: const Alignment(-0.9, -0.7),
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(3, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Text(
                'LEVEL 4',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Positioned(
            top: 185,
            left: 25,
            right: 25,
            child: LinearProgressIndicator(
              value: 0.75, // Progress (you can tweak if needed)
              backgroundColor: Colors.white,
              color: Colors.green,
              minHeight: 10,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          Align(
            alignment: const Alignment(0, 0.4),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF6FAED6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/level4/nuggets.png',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: options.map((option) {
                      Color buttonColor = const Color(0xFFABE7FF);
                      if (isAnswered && selectedAnswer == option) {
                        buttonColor = (option == correctAnswer)
                            ? Colors.green
                            : Colors.red;
                      }

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () => checkAnswer(option),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 55),
                            padding:
                            const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                          ),
                          child: Text(
                            option,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 25,
            left: 25,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const GamePage()),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFABE7FF),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Quit'),
            ),
          ),
        ],
      ),
    );
  }
}
