import 'package:flutter/material.dart';
import '/Pages/pedro_page.dart';

class DoneFlow extends StatefulWidget {
  final bool userTyped;
  final String userName;

  const DoneFlow({
    super.key,
    required this.userTyped,
    required this.userName,
  });

  @override
  State<DoneFlow> createState() => _DoneFlowState();
}

class _DoneFlowState extends State<DoneFlow> {
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> _nextPage(BuildContext context) async {
    FocusScope.of(context).unfocus();
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() {
      _currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userTyped) {
      return DoneScreen3(userName: widget.userName);
    }

    Widget page;
    if (_currentPage == 1) {
      page = DoneScreen1(onContinue: () => _nextPage(context));
    } else if (_currentPage == 2) {
      page = DoneScreen2(onContinue: () => _nextPage(context));
    } else {
      page = DoneScreen3(userName: widget.userName);
    }

    return Scaffold(body: page);
  }
}

Widget buildGradientBackground({required Widget child}) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFABE7FF), Color(0xFFFFE1A8)],
      ),
    ),
    child: SafeArea(child: child),
  );
}

// Screen 1
class DoneScreen1 extends StatelessWidget {
  final VoidCallback onContinue;
  const DoneScreen1({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onContinue,
      child: buildGradientBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "The person who wrote the poem has days where words don’t come too. That’s okay. Some days are quiet. Some days are full. All of them are human.",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Screen 2
class DoneScreen2 extends StatefulWidget {
  final VoidCallback onContinue;
  const DoneScreen2({super.key, required this.onContinue});

  @override
  State<DoneScreen2> createState() => _DoneScreen2State();
}

class _DoneScreen2State extends State<DoneScreen2>
    with TickerProviderStateMixin {
  late AnimationController _bubbleController;
  late AnimationController _raccoonController;
  late Animation<Offset> _bubbleSlide;
  late Animation<Offset> _raccoonSlide;

  @override
  void initState() {
    super.initState();

    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _raccoonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _bubbleSlide = Tween<Offset>(
      begin: const Offset(0, 1.2),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _bubbleController,
      curve: Curves.easeOutBack,
    ));

    _raccoonSlide = Tween<Offset>(
      begin: const Offset(0, 1.0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _raccoonController,
      curve: Curves.easeOutCubic,
    ));

    _raccoonController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _bubbleController.forward();
    });
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    _raccoonController.dispose();
    super.dispose();
  }

  Future<void> _continueWithPopOut() async {
    await Future.wait([
      _bubbleController.reverse(),
      _raccoonController.reverse(),
    ]);
    widget.onContinue();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _continueWithPopOut,
      child: buildGradientBackground(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: SlideTransition(
                position: _bubbleSlide,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 180),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text(
                      "I once tried to remember what I forgot... and forgot what I was remembering. Brains are funny that way.",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -10,
              left: -50,
              child: SlideTransition(
                position: _raccoonSlide,
                child: Transform.rotate(
                  angle: 0.20,
                  child: Image.asset(
                    'assets/pedrocrop.png',
                    width: 230,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Screen 3
class DoneScreen3 extends StatelessWidget {
  final String userName;
  const DoneScreen3({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PedroPage(userName: userName),
          ),
        );
      },
      child: buildGradientBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Today’s poetry is done! I’m happy you showed up. Thank you for being here today! I’ll be waiting for you again tomorrow.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/Celrc.png',
              width: 220,
            ),
          ],
        ),
      ),
    );
  }
}
