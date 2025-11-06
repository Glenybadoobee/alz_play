import 'package:flutter/material.dart';
import 'done_flow.dart';

class PoemPage extends StatefulWidget {
  final String title;
  final String userName;

  const PoemPage({
    super.key,
    required this.title,
    required this.userName,
  });

  @override
  State<PoemPage> createState() => _PoemPageState();
}


class _PoemPageState extends State<PoemPage> {
  bool isHearted = false;
  final TextEditingController _responseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFABE7FF), Color(0xFFFFE1A8)],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back, size: 28),
                      ),
                      const Icon(Icons.menu, size: 28),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // title
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Poem
                  const Text(
                    "There is music in small things,\n"

                        "in spoons touching cups,\n"
                        "in the whisper of curtains,\n"
                        "in birds who forget the world is heavy.\n\n"
                        "Listen closely.\n"
                        "Even silence has a hum\n"
                        "when your heart is kind enough\n"
                        "to notice.",
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),


                  const SizedBox(height: 15),

                  // Heart button
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        isHearted
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: isHearted ? Colors.pinkAccent : Colors.black54,
                        size: 26,
                      ),
                      onPressed: () {
                        setState(() {
                          isHearted = !isHearted;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Prompt text
                  const Text(
                    "What sound makes you smile?",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Text box
                  Container(
                    height: 130,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE1A8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _responseController,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type here...",
                        hintStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "If you don’t have the words right now, that’s okay. "
                        "Knowing you’ve read the poem we made for you is already enough for us. "
                        "You can just leave a heart if you want :>",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Done button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus(); // Remove focus first
                        bool userTyped = _responseController.text.isNotEmpty;

                        Future.delayed(const Duration(milliseconds: 400), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DoneFlow(
                                 userTyped: userTyped,
                                userName: widget.userName,
                            ),
                            ),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFABE7FF),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 40,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
