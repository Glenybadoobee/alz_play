import 'package:flutter/material.dart';
import '/Pages/guest_page.dart';

void main() {
  runApp(const AlzPlay());
}

class AlzPlay extends StatelessWidget {
  const AlzPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GuestPage(),
    );
  }
}
