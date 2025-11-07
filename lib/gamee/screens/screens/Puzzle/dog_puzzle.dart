import 'dart:math';
import 'package:flutter/material.dart';
import 'dog_piece.dart';
import '../Raccoon/standing_raccoon.dart';
import '../Puzzle/settings_page.dart';

class DogPuzzle extends StatefulWidget {
  const DogPuzzle({super.key});

  @override
  State<DogPuzzle> createState() => _DogPuzzleState();
}

class _DogPuzzleState extends State<DogPuzzle>
    with SingleTickerProviderStateMixin {
  final List<String> _images = [
    'assets/dog/dog_piece1.png',
    'assets/dog/dog_piece2.png',
    'assets/dog/dog_piece3.png',
    'assets/dog/dog_piece4.png',
    'assets/dog/dog_piece5.png',
    'assets/dog/dog_piece6.png',
    'assets/dog/dog_piece7.png',
    'assets/dog/dog_piece8.png',
    'assets/dog/dog_piece9.png',
  ];

  final List<Size> _pieceSizes = const [
    Size(102, 90),
    Size(143, 110),
    Size(101, 110),
    Size(102, 142),
    Size(143, 103),
    Size(101, 100),
    Size(102, 99),
    Size(143, 118),
    Size(101, 119),
  ];

  final Random _random = Random();
  late List<Piece> pieces;
  bool _initialized = false;
  final double snapTolerance = 25.0;
  final int _userCoins = 74;

  @override
  void initState() {
    super.initState();
    pieces = [];
  }

  void _initPieces(Size screenSize) {
    if (_initialized) return;
    _initialized = true;

    const double puzzleWidth = 346;
    const double puzzleHeight = 370;
    final double startX = (screenSize.width - puzzleWidth) / 2;
    final double startY = (screenSize.height - puzzleHeight) / 2;

    for (int i = 0; i < 9; i++) {
      final row = i ~/ 3;
      final col = i % 3;
      final correctX = startX + col * 115;
      final correctY = startY + row * 125;

      pieces.add(Piece(
        index: i,
        path: _images[i],
        size: _pieceSizes[i],
        x: 30 + _random.nextDouble() * (screenSize.width - 150),
        y: 150 + _random.nextDouble() * (screenSize.height - 250),
        correctX: correctX,
        correctY: correctY,
        rotationDeg: (_random.nextInt(4) * 90),
      ));
    }
  }

  void _snapPiece(Piece piece) {
    final dx = (piece.x - piece.correctX).abs();
    final dy = (piece.y - piece.correctY).abs();
    if (dx < snapTolerance && dy < snapTolerance) {
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
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(204),
                              borderRadius: BorderRadius.circular(8),
                              border:
                              Border.all(color: Colors.black54, width: 1.5),
                            ),
                            child: const Icon(Icons.menu,
                                size: 32, color: Colors.black87),
                          ),
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
                                child: Row(
                                  children: [
                                    const Icon(Icons.monetization_on,
                                        color: Colors.amber, size: 22),
                                    const SizedBox(width: 4),
                                    Text(
                                      '$_userCoins',
                                      style: const TextStyle(
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
                                  border: Border.all(color: Colors.black, width: 2),
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
                          builder: (_) => const HomeAloneRiles()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFABE7FF),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
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
