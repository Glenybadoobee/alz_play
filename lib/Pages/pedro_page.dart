import 'package:flutter/material.dart';
import '../Game/game_page.dart';
import '../Memories/memories.dart';
import '../poetry/poetry.dart';
import '../Feelings/feelings.dart';

class PedroPage extends StatelessWidget {
  final String userName;
  const PedroPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFABE7FF), Color(0xFFFFE1A8)],
              ),
            ),
          ),

          // Title
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

          // Coins
          Positioned(
            top: 120,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black26, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/coin.png',
                    width: 28,
                    height: 28,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    '120',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Greeting Text
          Positioned(
            top: 120,
            left: 25,
            child: Text(
              'Hello there,\n$userName',
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const Positioned(
            top: 240,
            left: 25,
            child: Text(
              "Let's make this day a\ngood memory!",
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),

          // Pedro
          Positioned(
            top: 280,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/pedrowave.png',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Action Buttons
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildActionButton(
                    color: const Color(0xFF8ED1FC),
                    icon: Icons.videogame_asset,
                    label: 'Game Time',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GamePage()),
                      );
                    },
                  ),
                  _buildActionButton(
                    color: const Color(0xFFFFD580),
                    icon: Icons.photo,
                    label: 'My Memories',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MemoriesPage()),
                      );
                    },
                  ),
                  _buildActionButton(
                    color: const Color(0xFFDAB6FC),
                    icon: Icons.create,
                    label: 'Poetry Time',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PoetryIntroPage(userName: userName)),
                      );
                    },
                  ),
                  _buildActionButton(
                    color: const Color(0xFFA7F0BA),
                    icon: Icons.emoji_emotions,
                    label: 'Journal',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FeelingsPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required Color color,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black26, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 45, color: Colors.black87),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Shop Button
class _ShopButtonSmall extends StatelessWidget {
  const _ShopButtonSmall();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Shop tapped!");
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black26, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          'assets/Store.png',
          width: 25,
          height: 25,
        ),
      ),
    );
  }
}