import 'package:flutter/material.dart';
import 'journal_data.dart';
import 'done_page.dart';

class JournalEntryPage extends StatefulWidget {
  final String moodEmoji;

  const JournalEntryPage({super.key, required this.moodEmoji});

  @override
  State<JournalEntryPage> createState() => _JournalEntryPageState();
}

class _JournalEntryPageState extends State<JournalEntryPage> {
  final TextEditingController _controller = TextEditingController();
  DateTime? selectedDate;

  /// Function to pick a date
  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  /// Function to save the journal entry
  void _saveEntry() {
    String entryText = _controller.text.trim();

    if (entryText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please write something before saving.")),
      );
      return;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a date first.")),
      );
      return;
    }

    /// entry to the shared journal list
    journalEntries.add(
      JournalEntry(
        date: "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}",
        mood: widget.moodEmoji,
        text: entryText,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Your entry has been saved!")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DonePage()),
    );
  }

  String _getMoodImage(String mood) {
    switch (mood) {
      case "happy":
        return "assets/images/happy.png";
      case "neutral":
        return "assets/images/neutral.png";
      case "sad":
        return "assets/images/sad.png";
      default:
        return "assets/images/neutral.png";
    }
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Image.asset(
                  _getMoodImage(widget.moodEmoji),
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today, color: Colors.black),
                    label: Text(
                      selectedDate == null
                          ? "Set Date"
                          : "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}",
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),

                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: "Write your thoughts here...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _actionButton("Back", () => Navigator.pop(context)),
                    _actionButton("Save", _saveEntry),
                  ],
                ),
              ],
            ),
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
