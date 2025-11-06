import 'package:flutter/material.dart';
import 'poetry_days_page.dart';

class PoetryIntroPage extends StatefulWidget {
  final String userName;

  const PoetryIntroPage({
    super.key,
    required this.userName,
  });

  @override
  State<PoetryIntroPage> createState() => _PoetryIntroPageState();
}

class _PoetryIntroPageState extends State<PoetryIntroPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _isGoingDown = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 1.2),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  void _onTap() async {
    if (_isGoingDown) return;
    _isGoingDown = true;

    await _controller.reverse();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PoetryDaysPage(
            title: "Poetry Time!",
            userName: widget.userName,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _onTap,
        child: Stack(
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
            const Positioned(
              top: 250,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Poetry Time!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -40,
              child: SlideTransition(
                position: _animation,
                child: Image.asset(
                  'assets/poetrac.png',
                  width: 260,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
