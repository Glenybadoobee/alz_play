import 'package:flutter/material.dart';
import 'journal_entry_page.dart';

class FeelingsPage extends StatefulWidget {
  const FeelingsPage({super.key});

  @override
  State<FeelingsPage> createState() => _FeelingsPageState();
}

class _FeelingsPageState extends State<FeelingsPage> {
  String? _selectedMood;

  void _selectMood(String moodName) {
    setState(() {
      _selectedMood = moodName;
    });


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JournalEntryPage(
          moodEmoji: moodName,
        ),
      ),
    );
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
            children: [
              const SizedBox(height: 60),
              const Text(
                'How are you today?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _moodButton("assets/images/happy.png", "happy"),
                  const SizedBox(width: 20),
                  _moodButton("assets/images/neutral.png", "neutral"),
                  const SizedBox(width: 20),
                  _moodButton("assets/images/sad.png", "sad"),
                ],
              ),

              const SizedBox(height: 60),
              _actionButton("Back", () => Navigator.pop(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _moodButton(String imagePath, String moodName) {
    return GestureDetector(
      onTap: () => _selectMood(moodName),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          Text(
            moodName[0].toUpperCase() + moodName.substring(1),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFABE7FF),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}
