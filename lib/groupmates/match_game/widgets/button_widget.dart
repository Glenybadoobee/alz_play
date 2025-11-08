import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFABE7FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
