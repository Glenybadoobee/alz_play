import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '/Pages/pedro_page.dart';
import '/Pages/settings_page.dart';
import '/Pages/shop_page.dart';


class HomePage extends StatefulWidget {
  final String userName;
  const HomePage({super.key, required this.userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer _player = AudioPlayer();
  double _volume = 0.5;

  @override
  void initState() {
    super.initState();
    _initMusic();
  }

  Future<void> _initMusic() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setSource(AssetSource('audio/background_music.mp3'));
    await _player.setVolume(_volume);
    _player.resume();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }


  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E1E1E), Color(0xFF2C2C2C)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        '⚙️ Settings',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Account Info',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Username: ${widget.userName}',
                      style: const TextStyle(color: Colors.white),
                    ),

                    const Divider(height: 30, color: Colors.white24),

                    const Text(
                      'Sound',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.volume_down, color: Colors.white70),
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.lightBlueAccent,
                              inactiveTrackColor: Colors.white24,
                              thumbColor: Colors.blueAccent,
                              overlayColor: Colors.blueAccent.withOpacity(0.3),
                            ),
                            child: Slider(
                              value: _volume,
                              min: 0,
                              max: 1,
                              divisions: 10,
                              onChanged: (value) {
                                setModalState(() {
                                  _volume = value;
                                });
                                setState(() {
                                  _volume = value;
                                });
                                _player.setVolume(value);
                              },
                            ),
                          ),
                        ),
                        const Icon(Icons.volume_up, color: Colors.white70),
                      ],
                    ),

                    const Spacer(),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFABE7FF), Color(0xFFFFE1A8)],
              ),
            ),
          ),

          // App Title
          const Positioned(
            top: 58,
            left: 20,
            child: Text(
              'AlzPlay',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Menu Button
          Positioned(
            top: 65,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.menu),
              iconSize: 30,
              color: Colors.black87,
              onPressed: () async {
                final newVolume = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsPage(
                      player: _player,
                      currentVolume: _volume,
                    ),
                  ),
                );

                if (newVolume != null) {
                  setState(() {
                    _volume = newVolume;
                  });
                }
              },

            ),
          ),

          // Coin Display
          Positioned(
            top: 120,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black26, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/coin.png', width: 28, height: 28),
                  const SizedBox(width: 6),
                  const Text(
                    '0',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Shop Button
          const Positioned(top: 130, left: 20, child: ShopButton()),

          // Quote
          const Positioned(
            top: 225,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'Memories are better when shared,\nwho will you make them with today?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),

          // Mascots
          Positioned(
            top: 330,
            left: 0,
            right: 0,
            child: Center(
              child: Wrap(
                spacing: 30,
                runSpacing: 30,
                alignment: WrapAlignment.center,
                children: [
                  buildMascotBox(
                    context,
                    'assets/pedrocrop.png',
                    'Pedro',
                    boxColor: const Color(0xFFD9A679),
                    scale: 1.1,
                    offset: const Offset(1, 3.5),
                  ),
                  buildMascotBox(
                    context,
                    'assets/shykenn.png',
                    'Shyken Nuggets',
                    locked: true,
                    boxColor: const Color(0xFFFFD580),
                    scale: 1.04,
                    offset: const Offset(-2, 4.2),
                  ),
                  buildMascotBox(
                    context,
                    'assets/gregorr.png',
                    'Gregor Samsa',
                    locked: true,
                    boxColor: const Color(0xFFC2F0A5),
                    scale: 1.07,
                    offset: const Offset(-3, -0.2),
                  ),
                  buildMascotBox(
                    context,
                    'assets/dutchcrop.png',
                    'Dutch',
                    locked: true,
                    boxColor: const Color(0xFFFFB6C1),
                    scale: 1.20,
                    offset: const Offset(-1, 6),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Mascot Box Widget
  Widget buildMascotBox(
      BuildContext context,
      String imagePath,
      String name, {
        bool locked = false,
        required Color boxColor,
        double scale = 1.0,
        Offset offset = Offset.zero,
      }) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topRight,
          children: [
            GestureDetector(
              onTap: () {
                if (locked) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$name is not available yet :('),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  return;
                }
                if (name == 'Pedro') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PedroPage(userName: widget.userName),
                    ),
                  );
                }
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black26, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Transform.translate(
                    offset: offset,
                    child: Transform.scale(
                      scale: scale,
                      child: Image.asset(imagePath, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
            ),
            if (locked)
              const Positioned(
                top: -10,
                right: -8,
                child: Icon(Icons.lock, size: 35, color: Colors.black54),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

// Shop Button Widget
class ShopButton extends StatelessWidget {
  const ShopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ShopPage()),
            );
          },

          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black26, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: Image.asset('assets/Store.png', width: 25, height: 25),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Shop',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}