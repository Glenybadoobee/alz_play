import 'package:flutter/material.dart';
import 'view_journal_page.dart';
import 'journal_data.dart';
import '/Pages/pedro_page.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

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
              const Text(
                "Journal entry completed!\nI'll be waiting for you again tomorrow.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Image.asset('assets/Celrc.png', height: 250),
              const SizedBox(height: 40),

              // ✅ Buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _actionButton(
                    "View Journal",
                        () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ViewJournalPage(entries: journalEntries),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  _actionButton(
                    "Home",
                        () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PedroPage(userName: ""),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFABE7FF),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}
