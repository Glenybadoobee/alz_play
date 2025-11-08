import 'package:flutter/material.dart';
import 'package:alz_play/gamee/screens/levels/level1_screen.dart';
import 'package:alz_play/gamee/screens/screens/Puzzle/dog_puzzle.dart';
import '/groupmates/match_game/match_game_page.dart';


class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double _scale = 1.0;
  double _rotation = 0.0;

  void _onTapDown() {
    setState(() {
      _scale = 0.85;
      _rotation = 0.1;
    });
  }

  void _onTapUp(BuildContext context) {
    setState(() {
      _scale = 1.0;
      _rotation = 0.0;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      Navigator.pop(context);
      print("Closed game menu!");
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

          //Title
          const Positioned(
            top: 58,
            left: 20,
            child: Text(
              'AlzPlay',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Menu Button
          Positioned(
            top: 65,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.menu),
              iconSize: 30,
              color: Colors.black87,
              onPressed: () {
                print("Menu opened!");
              },
            ),
          ),


          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Blue frame
                Container(
                  width: 320,
                  height: 400,
                  decoration: BoxDecoration(
                    color: const Color(0xFF74B9FF),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Games',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Game list
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          children: [
                            _buildGameOption(
                              imagePath: 'assets/puzzle.jpg',
                              bgColor: const Color(0xFFE96DFF),
                              gameName: 'Puzzle',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const DogPuzzle()),
                                );
                              },
                            ),

                            const SizedBox(height: 15),
                            _buildGameOption(
                              imagePath: 'assets/puzzle.jpg',
                              bgColor: const Color(0xFFF6E36A),
                              gameName: 'Match',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const MatchGamePage()),
                                );
                              },
                            ),

                            const SizedBox(height: 15),
                            _buildGameOption(
                              imagePath: 'assets/puzzle.jpg',
                              bgColor: const Color(0xFF9E9E9E),
                              gameName: 'Guess',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Level1Screen()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


                Positioned(
                  top: -15,
                  right: -15,
                  child: GestureDetector(
                    onTapDown: (_) => _onTapDown(),
                    onTapUp: (_) => _onTapUp(context),
                    onTapCancel: () => setState(() {
                      _scale = 1.0;
                      _rotation = 0.0;
                    }),
                    child: AnimatedScale(
                      scale: _scale,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                      child: AnimatedRotation(
                        turns: _rotation,
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeInOut,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const Center(
                            child: Text(
                              'X',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Comic Sans MS',
                                height: 1,
                                shadows: [
                                  Shadow(
                                    color: Colors.black38,
                                    offset: Offset(1.5, 1.5),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameOption({
    required String imagePath,
    required Color bgColor,
    required String gameName,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [

            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imagePath.trim(),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 15),

            // Game image
            Text(
              gameName,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black38,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
