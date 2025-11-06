import 'package:flutter/material.dart';
import 'poem_page.dart';

class PoetryDaysPage extends StatefulWidget {
  final String title;
  final String userName;

  const PoetryDaysPage({
    super.key,
    required this.title,
    required this.userName,
  });

  @override
  State<PoetryDaysPage> createState() => _PoetryDaysPageState();
}

class _PoetryDaysPageState extends State<PoetryDaysPage> {
  int unlockedDay = 1;

  void _showLockedMessage(BuildContext context, int day) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('This poem unlocks on Day $day!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildMainPoemTile({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPoemTile({
    required String title,
    required bool locked,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: locked ? null : onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                locked ? Icons.lock_outline_rounded : Icons.lock_open_rounded,
                color: locked ? Colors.black87 : Colors.green,
              ),
            ),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: locked ? Colors.grey.shade600 : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
          Column(
            children: [
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, size: 28),
                    ),
                    const Spacer(),
                    const Icon(Icons.menu, size: 28),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Poetry Time!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: Container(
                  width: 350,
                  height: 515,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9CC7E7),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildMainPoemTile(
                        title: "All The Little Things That Sing",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PoemPage(
                                title: "All The Little Things That Sing",
                                userName: widget.userName,
                              ),
                            ),
                          );
                        },
                      ),
                      for (int day = 2; day <= 7; day++)
                        _buildPoemTile(
                          title: day == 2 ? "Still Water" : "Day $day",
                          locked: day > unlockedDay,
                          onTap: day > unlockedDay
                              ? () => _showLockedMessage(context, day)
                              : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PoemPage(
                                  title: "Day $day Poem",
                                  userName: widget.userName,
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
