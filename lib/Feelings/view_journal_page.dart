import 'package:flutter/material.dart';
import 'journal_data.dart';

class ViewJournalPage extends StatefulWidget {
  final List<JournalEntry> entries;

  const ViewJournalPage({super.key, required this.entries});

  @override
  State<ViewJournalPage> createState() => _ViewJournalPageState();
}

class _ViewJournalPageState extends State<ViewJournalPage> {
  int? _expandedIndex;
  int? _editingIndex;
  final Map<int, TextEditingController> _controllers = {};

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

  void _deleteEntry(int index) {
    setState(() {
      widget.entries.removeAt(index);
      _controllers.remove(index);
      if (_expandedIndex == index) _expandedIndex = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Entry deleted successfully")),
    );
  }

  void _toggleEdit(int index) {
    setState(() {
      if (_editingIndex == index) {
        // Stop editing (save automatically)
        widget.entries[index] = JournalEntry(
          date: widget.entries[index].date,
          mood: widget.entries[index].mood,
          text: _controllers[index]!.text,
        );
        _editingIndex = null;
      } else {
        // Start editing
        _editingIndex = index;
        _controllers[index] ??=
            TextEditingController(text: widget.entries[index].text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final entries = widget.entries;

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
              const SizedBox(height: 20),
              const Text(
                "My Journal Entries",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: entries.isEmpty
                    ? const Center(
                  child: Text(
                    "You have no entries yet.",
                    style: TextStyle(fontSize: 18),
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    final isExpanded = _expandedIndex == index;
                    final isEditing = _editingIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _expandedIndex =
                          isExpanded ? null : index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin:
                        const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black26),
                          boxShadow: isExpanded
                              ? [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                              : [],
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  _getMoodImage(entry.mood),
                                  width: 40,
                                  height: 40,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry.date,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Tap to view entry",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: isExpanded
                                            ? Colors.blueGrey
                                            : Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Animated reveal
                            AnimatedCrossFade(
                              duration:
                              const Duration(milliseconds: 300),
                              crossFadeState: isExpanded
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              firstChild: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  isEditing
                                      ? TextField(
                                    controller:
                                    _controllers[index],
                                    maxLines: null,
                                    decoration:
                                    const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText:
                                      "Write your thoughts...",
                                    ),
                                  )
                                      : Text(
                                    entry.text,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      height: 1.4,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      TextButton.icon(
                                        icon: Icon(
                                          isEditing
                                              ? Icons.check
                                              : Icons.edit,
                                          size: 18,
                                          color: Colors.blueAccent,
                                        ),
                                        label: Text(
                                          isEditing
                                              ? "Save"
                                              : "Edit",
                                          style: const TextStyle(
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                        onPressed: () =>
                                            _toggleEdit(index),
                                      ),
                                      const SizedBox(width: 10),
                                      TextButton.icon(
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 18,
                                          color: Colors.redAccent,
                                        ),
                                        label: const Text(
                                          "Delete",
                                          style: TextStyle(
                                              color:
                                              Colors.redAccent),
                                        ),
                                        onPressed: () =>
                                            _deleteEntry(index),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              secondChild: const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFABE7FF),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Close",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
