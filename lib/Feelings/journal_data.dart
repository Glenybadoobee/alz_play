// lib/Feelings/journal_data.dart
library journal_data;

class JournalEntry {
  final String date;
  final String mood;
  final String text;

  JournalEntry({required this.date, required this.mood, required this.text});
}

List<JournalEntry> journalEntries = [];
