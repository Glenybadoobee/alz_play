import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CoinManager {
  CoinManager._internal();
  static final CoinManager instance = CoinManager._internal();

  static const String _prefsKey = 'coins';


  final ValueNotifier<int> coins = ValueNotifier<int>(0);


  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    coins.value = prefs.getInt(_prefsKey) ?? 0;
  }

  Future<void> setCoins(int value) async {
    coins.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefsKey, value);
  }


  Future<void> addCoins(int delta) async {
    return setCoins(coins.value + delta);
  }


  int get current => coins.value;
}
