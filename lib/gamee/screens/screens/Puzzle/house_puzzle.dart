import 'dart:math';
import 'package:flutter/material.dart';
import 'house_piece.dart';
import '../joli/cute_raccoon.dart';
import '../Puzzle/settings_page.dart';

class HousePuzzleScreen extends StatefulWidget {
  const HousePuzzleScreen({super.key});

  @override
  State<HousePuzzleScreen> createState() => _HousePuzzleScreenState();
}

class _HousePuzzleScreenState extends State<HousePuzzleScreen> {
  final List<String> _images = [
    'assets/house/house_piece1.png',
    'assets/house/house_piece2.png',
    'assets/house/house_piece3.png',
    'assets/house/house_piece4.png',
    'assets/house/house_piece5.png',
    'assets/house/house_piece6.png',
    'assets/house/house_piece7.png',
    'assets/house/house_piece8.png',
    'assets/house/house_piece9.png',
    'assets/house/house_piece10.png',
    'assets/house/house_piece11.png',
    'assets/house/house_piece12.png',
  ];

  final List<Size> _pieceSizes = const [
    Size(77, 77),
    Size(94, 77),
    Size(94, 77),
    Size(94, 94),
    Size(94, 111),
    Size(77, 94),
    Size(77, 111),
    Size(111, 94),
    Size(77, 94),
    Size(94, 77),
    Size(77, 77),
    Size(94, 94),
  ];

  final Random _random = Random();
  late List<Piece> pieces;
  bool _initialized = false;
  final double snapTolerance = 25.0;
  final int _userCoins = 74; // example coins

  @override
  void initState() {
    super.initState();
    pieces = [];
  }

  void _initPieces(Size screenSize) {
    if (_initialized) return;
    _initialized = true;

    const double puzzleWidth = 290;
    const double puzzleHeight = 360;
    final double startX = (screenSize.width - puzzleWidth) / 2;
    final double startY = (screenSize.height - puzzleHeight) / 2;

    for (int i = 0; i < _images.length; i++) {
      final row = i ~/ 3;
      final col = i % 3;
      final correctX = startX + col * 95;
      final correctY = startY + row * 95;

      pieces.add(Piece(
        index: i,
        path: _images[i],
        size: _pieceSizes[i],
        x: 40 + _random.nextDouble() * (screenSize.width - 140),
        y: 150 + _random.nextDouble() * (screenSize.height - 250),
        rotationDeg: (_random.nextInt(4) * 90),
        correctX: correctX,
        correctY: correctY,
      ));
    }
  }

  void _snapPiece(Piece piece) {
    final dx = (piece.x - piece.correctX).abs();
    final dy = (piece.y - piece.correctY).abs();

    if (dx < snapTolerance && dy < snapTolerance && piece.rotationDeg % 360 == 0) {
      setState(() {
        piece.x = piece.correctX;
        piece.y = piece.correctY;
        piece.rotationDeg = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    _initPieces(screen);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFBEE9FF), Color(0xFFFFE5B4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Header: AlzPlay + Menu + Coins
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AlzPlay',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),

                    // Menu + Coins stacked vertically
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SettingsPage()),
                            );
                          },
                          child: const Icon(Icons.menu, size: 36, color: Colors.black87),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.yellow[700],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.monetization_on, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                '$_userCoins',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Puzzle pieces
              ...pieces.map((p) => Positioned(
                left: p.x,
                top: p.y,
                width: p.size.width,
                height: p.size.height,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      p.rotationDeg = (p.rotationDeg + 90) % 360;
                    });
                    _snapPiece(p);
                  },
                  onPanUpdate: (d) {
                    setState(() {
                      p.x += d.delta.dx;
                      p.y += d.delta.dy;
                    });
                  },
                  onPanEnd: (_) => _snapPiece(p),
                  child: Transform.rotate(
                    angle: p.rotationDeg * pi / 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        p.path,
                        width: p.size.width,
                        height: p.size.height,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )),


              Positioned(
                bottom: 20,
                right: 20,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RaccoonPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFABE7FF),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}