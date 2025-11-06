import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioPlayer _player = AudioPlayer();
  static bool _isPlaying = false;
  static double _volume = 0.5;

  static AudioPlayer get player => _player;

  static Future<void> initMusic() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setSource(AssetSource('audio/background_music.mp3'));
    await _player.setVolume(_volume);
    if (!_isPlaying) {
      await _player.resume();
      _isPlaying = true;
    }
  }

  static Future<void> stopMusic() async {
    await _player.stop();
    _isPlaying = false;
  }

  static Future<void> setVolume(double value) async {
    _volume = value;
    await _player.setVolume(value);
  }

  static double getVolume() => _volume;

  static bool get isPlaying => _isPlaying;
}
