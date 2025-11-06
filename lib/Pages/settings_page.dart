import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SettingsPage extends StatefulWidget {
  final AudioPlayer player;
  final double currentVolume;

  const SettingsPage({
    super.key,
    required this.player,
    required this.currentVolume,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _musicVolume = 0.5;
  double _soundEffectVolume = 0.5;

  double _scale = 1.0;
  double _rotation = 0.0;

  @override
  void initState() {
    super.initState();
    _musicVolume = widget.currentVolume;
  }

  void _onTapDown() {
    setState(() {
      _scale = 0.9;
      _rotation = 0.05;
    });
  }

  void _onTapUp(BuildContext context) {
    setState(() {
      _scale = 1.0;
      _rotation = 0.0;
    });
    Navigator.pop(context, _musicVolume);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE1A8),
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFABE7FF), Color(0xFFFFE1A8)],
              ),
            ),
          ),

          // Blue panel
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Outer Blue Panel
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.65,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  decoration: BoxDecoration(
                    color: const Color(0xFF39A3CF),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFF083B55),
                      width: 10,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ..._buildSpots(),

                      //gray box
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,   // ← adjust width (70% of screen)
                          height: MediaQuery.of(context).size.height * 0.8, // ← adjust height (40% of screen)
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAE7E7),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                          margin: const EdgeInsets.only(top: 60),
                          // spacing from top
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Account',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 18,
                                  shadows: [
                                    Shadow(
                                      color: Colors.white,
                                      blurRadius: 2,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 25),

                              // 🎵 Music slider
                              _buildSliderTile(
                                icon: Icons.music_note,
                                label: 'Music',
                                value: _musicVolume,
                                onChanged: (value) {
                                  setState(() => _musicVolume = value);
                                  widget.player.setVolume(value);
                                },
                              ),
                              const SizedBox(height: 25),

                              // Sound slider
                              _buildSliderTile(
                                icon: Icons.volume_up,
                                label: 'Sound Effect',
                                value: _soundEffectVolume,
                                onChanged: (value) {
                                  setState(() => _soundEffectVolume = value);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Positioned(
                        top: 8,
                        left: 75,
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black38,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Close button
                Positioned(
                  top: -15,
                  right: -15,
                  child: GestureDetector(
                    onTapDown: (_) => _onTapDown(),
                    onTapUp: (_) => _onTapUp(context),
                    onTapCancel: () => setState(() {
                      _scale = 1.0;
                      _rotation = 0.0;
                    }),
                    child: AnimatedScale(
                      scale: _scale,
                      duration: const Duration(milliseconds: 100),
                      child: AnimatedRotation(
                        turns: _rotation,
                        duration: const Duration(milliseconds: 150),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.redAccent.shade400,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 6,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'X',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Comic Sans MS',
                                shadows: [
                                  Shadow(
                                    color: Colors.black38,
                                    offset: Offset(2, 2),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // spots
  List<Widget> _buildSpots() {
    return [

      //top
      Positioned(top: -51, left: -29, child: _spot(41)),
      Positioned(top: -59, left: -3, child: _spot(30)),
      Positioned(top: -45, left: 70, child: _spot(20)),
      Positioned(top: -35, left: 210, child: _spot(10)),
      Positioned(top: -20, left: 225, child: _spot(20)),
      Positioned(top: 1, left: -16, child: _spot(10)),
      Positioned(top: 18, left: 25, child: _spot(10)),
      Positioned(top: -65, left: 260, child: _spot(60)),

      // bottom

    ];
  }

  Widget _spot(double size) => Container(
    width: size,
    height: size,
    decoration: const BoxDecoration(
      color: Color(0xFF083B55),
      shape: BoxShape.circle,
    ),
  );


  Widget _buildSliderTile({
    required IconData icon,
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFB3E5FC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black26, width: 1.5),
            ),
            child: Icon(icon, color: const Color(0xFF083B55), size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 4,
                    activeTrackColor: const Color(0xFF1E88E5),
                    inactiveTrackColor: Colors.grey[300],
                    thumbColor: const Color(0xFF1E88E5),
                    thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 8),
                  ),
                  child: Slider(
                    value: value,
                    min: 0,
                    max: 1,
                    divisions: 10,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
