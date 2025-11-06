import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final VoidCallback? onMenuPressed;
  final int coins;

  const TopBar({
    super.key,
    this.onMenuPressed,
    this.coins = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // App title
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

        // Menu button
        Positioned(
          top: 65,
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.menu),
            iconSize: 30,
            color: Colors.black87,
            onPressed: onMenuPressed,
          ),
        ),

        // Coin
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
                Image.asset('assets/coin.png', width: 28, height: 28),
                const SizedBox(width: 6),
                Text(
                  coins.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
