import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import '/widgets/gradient_scaffold.dart';

class MemoriesPage extends StatefulWidget {
  const MemoriesPage({super.key});

  @override
  State<MemoriesPage> createState() => _MemoriesPageState();
}

class _MemoriesPageState extends State<MemoriesPage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> _memories = [];
  final AudioPlayer _player = AudioPlayer();
  int? _playingIndex;

  // Animation for play button bounce
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  final double _recordsFontSize = 40;
  final Color _recordsColor = Colors.black;
  final double _recordsTop = 100;
  final double _recordsLeft = 0;
  final double _recordsRight = 0;

  final double _mascotSize = 200;
  final double _mascotBottom = -1;
  final double _mascotLeft = 0;
  final double _mascotRight = 0;


  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.9,
      upperBound: 1.0,
    );
    _scaleAnimation =
        CurvedAnimation(parent: _animController, curve: Curves.easeInOut);
  }

  Future<void> _pickAudioFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a'],
    );

    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;

      final TextEditingController titleController = TextEditingController();
      String? customTitle = await showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Name your recording"),
            content: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Enter a title...",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, titleController.text.trim());
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      );

      if (customTitle != null && customTitle.isNotEmpty) {
        setState(() {
          _memories.add({
            'title': customTitle,
            'path': path,
          });
        });
      }
    }
  }

  Future<void> _renameAudio(int index) async {
    final TextEditingController controller = TextEditingController(
      text: _memories[index]['title'],
    );

    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Rename Recording"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter a new name...",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, controller.text.trim()),
            child: const Text("Save"),
          ),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty) {
      setState(() {
        _memories[index]['title'] = newName;
      });
    }
  }

  Future<void> _playPauseAudio(int index) async {
    final path = _memories[index]['path']!;
    await _animController.forward(from: 0.9);

    if (_playingIndex == index) {
      await _player.pause();
      setState(() => _playingIndex = null);
    } else {
      await _player.stop();
      await _player.play(DeviceFileSource(path));
      setState(() => _playingIndex = index);

      _player.onPlayerComplete.listen((_) {
        setState(() => _playingIndex = null);
      });
    }
  }

  void _deleteAudio(int index) {
    setState(() {
      if (_playingIndex == index) _player.stop();
      _memories.removeAt(index);
      _playingIndex = null;
    });
  }

  @override
  void dispose() {
    _player.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header row
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 28),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      Positioned(
                        top: _recordsTop,
                        left: _recordsLeft,
                        right: _recordsRight,
                        child: Center(
                          child: Text(
                            "Records",
                            style: TextStyle(
                              fontSize: _recordsFontSize,
                              fontWeight: FontWeight.bold,
                              color: _recordsColor,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(flex: 2),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // List of memories
                Expanded(
                  child: ListView.builder(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    itemCount: _memories.length,
                    itemBuilder: (context, index) {
                      final memory = _memories[index];
                      final isPlaying = _playingIndex == index;

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: ScaleTransition(
                                  scale: _scaleAnimation,
                                  child: GestureDetector(
                                    onTap: () => _playPauseAudio(index),
                                    child: AnimatedContainer(
                                      duration:
                                      const Duration(milliseconds: 250),
                                      width: 46,
                                      height: 46,
                                      decoration: BoxDecoration(
                                        color: isPlaying
                                            ? Colors.orange
                                            : Colors.blue,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  memory['title']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                trailing: PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'delete') {
                                      _deleteAudio(index);
                                    } else if (value == 'rename') {
                                      _renameAudio(index);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'rename',
                                      child: Text('Rename'),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                                  icon: const Icon(Icons.more_vert),
                                ),
                              ),


                              if (isPlaying)
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 70, bottom: 8),
                                  child: AnimatedOpacity(
                                    opacity: 1.0,
                                    duration:
                                    const Duration(milliseconds: 300),
                                    child: _AnimatedNowPlayingText(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            Positioned(
              bottom: 180,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: _pickAudioFile,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black87,
                    ),
                    child: const Icon(Icons.add, size: 50, color: Colors.white),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: _mascotBottom,
              left: _mascotLeft,
              right: _mascotRight,
              child: Center(
                child: Image.asset(
                  'assets/pedrocrop.png',
                  height: _mascotSize,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedNowPlayingText extends StatefulWidget {
  @override
  State<_AnimatedNowPlayingText> createState() =>
      _AnimatedNowPlayingTextState();
}

class _AnimatedNowPlayingTextState extends State<_AnimatedNowPlayingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Opacity(
          opacity: 0.5 + 0.5 * _controller.value,
          child: Text(
            "Now playing...",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.orange[800],
            ),
          ),
        );
      },
    );
  }
}
