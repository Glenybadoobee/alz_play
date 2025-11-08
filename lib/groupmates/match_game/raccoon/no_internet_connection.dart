import 'dart:math';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen>
    with TickerProviderStateMixin {
  late final AnimationController _loadingController;

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  void _goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Color(0xFFFFE0B2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back,
                        size: 30, color: Colors.black),
                    onPressed: _goBack,
                  ),
                ),
              ),

              const Spacer(),

              const Text(
                'No Internet Connection',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 30),


              SizedBox(
                width: 100,
                height: 100,
                child: AnimatedBuilder(
                  animation: _loadingController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter:
                      StepRotatingBarPainter(_loadingController.value),
                    );
                  },
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}


class StepRotatingBarPainter extends CustomPainter {
  final double progress;
  StepRotatingBarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    const int barCount = 8;
    const double barWidth = 8;
    const double innerRadius = 32;
    const double outerRadius = 55;

    final Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = barWidth;


    for (int i = 0; i < barCount; i++) {
      final double angle = (2 * pi / barCount) * i;
      final double xStart = size.width / 2 + innerRadius * cos(angle);
      final double yStart = size.height / 2 + innerRadius * sin(angle);
      final double xEnd = size.width / 2 + outerRadius * cos(angle);
      final double yEnd = size.height / 2 + outerRadius * sin(angle);

      paint.color = Colors.white;
      canvas.drawLine(Offset(xStart, yStart), Offset(xEnd, yEnd), paint);
    }


    const int steps = barCount;
    final int currentStep = (progress * steps).floor() % steps;
    final double activeAngle = (2 * pi / barCount) * currentStep;

    final double xStart = size.width / 2 + innerRadius * cos(activeAngle);
    final double yStart = size.height / 2 + innerRadius * sin(activeAngle);
    final double xEnd = size.width / 2 + outerRadius * cos(activeAngle);
    final double yEnd = size.height / 2 + outerRadius * sin(activeAngle);

    paint.color = Colors.black;
    canvas.drawLine(Offset(xStart, yStart), Offset(xEnd, yEnd), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
