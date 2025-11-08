import 'package:flutter/material.dart';

class CoinDisplay extends StatelessWidget {
  final int coins;
  const CoinDisplay({super.key, required this.coins});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF56B9E0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.monetization_on, color: Colors.yellow, size: 24),
          const SizedBox(width: 6),
          Text(
            coins.toString(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
