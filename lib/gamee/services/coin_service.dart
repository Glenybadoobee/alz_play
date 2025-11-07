import 'package:shared_preferences/shared_preferences.dart';

class CoinService {
  static const String _coinKey = 'user_coins';

  static Future<int> getCoins() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_coinKey) ?? 0;
  }

  static Future<void> setCoins(int coins) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_coinKey, coins);
  }

  static Future<void> addCoins(int amount) async {
    final currentCoins = await getCoins();
    await setCoins(currentCoins + amount);
  }

  static Future<void> resetCoins() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_coinKey, 0);
  }
}
