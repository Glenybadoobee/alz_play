
import 'package:flutter/material.dart';
import '../Puzzle/settings_page.dart';
import 'loading_screen.dart';

class OksPage extends StatefulWidget {
  const OksPage({super.key});

  @override
  State<OksPage> createState() => _OksPageState();
}

class _OksPageState extends State<OksPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bubbleOpacity;

  @override
  void initState() {
    super.initState();


    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _bubbleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFABE7FF), Color(0xFFFFE1A8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 🧩 Header (AlzPlay, coins, menu)
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'AlzPlay',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black87,
                      ),
                    ),
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
                                child: const Row(
                                  children: [
                                    Icon(Icons.monetization_on,
                                        color: Colors.amber, size: 22),
                                    SizedBox(width: 4),
                                    Text(
                                      '62',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
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


              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Speech bubble with fade animation
                    FadeTransition(
                      opacity: _bubbleOpacity,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        margin: const EdgeInsets.only(bottom: 6),
                        constraints: const BoxConstraints(maxWidth: 180),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'I love watching you'
                              ' focus like that.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),

                    // 🦝 Raccoon image
                    SizedBox(
                      height: 100,
                      child: Image.asset(
                        'assets/folder1/raccoon2.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(
                          height: 90,
                          child: Center(
                            child: Icon(
                              Icons.pets,
                              size: 36,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),


                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoadingPage()),
                        );
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
