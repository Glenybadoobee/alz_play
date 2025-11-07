import 'package:flutter/material.dart';
import '/widgets/gradient_scaffold.dart';
import '/widgets/top_bar.dart';
import '/widgets/settings_panel.dart';
import 'package:audioplayers/audioplayers.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final AudioPlayer _player = AudioPlayer();
  double _currentVolume = 0.5;
  bool _showSettings = false;
  int userCoins = 0;

  double _scale = 1.0;
  double _rotation = 0.0;

  // shop items
  final List<Map<String, dynamic>> shopItems = [
    {"image": "assets/pedrocrop.png", "owned": true, "price": 0},
    {"image": "assets/shykenn.png", "owned": false, "price": 500},
    {"image": "assets/dutchcrop.png", "owned": false, "price": 1000},
    {"image": "assets/gregorr.png", "owned": false, "price": 1500},
  ];

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Stack(
        children: [
          // blue container
          Positioned(
            top: 190,
            left: 20,
            right: 20,
            child: Container(
              height: 520,
              decoration: BoxDecoration(
                color: const Color(0xFF39A3CF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF083B55), width: 7),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 15),

                  const Text(
                    'Store',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
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

                  const SizedBox(height: 4),

                  // gray box
                  SizedBox(
                    height: 390,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAE7E7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: GridView.builder(
                        padding: const EdgeInsets.all(15),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: shopItems.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (context, index) {
                          final item = shopItems[index];
                          return _buildShopItem(
                            image: item["image"],
                            owned: item["owned"],
                            price: item["price"],
                            index: index,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // bar
          TopBar(
            coins: userCoins,
            onMenuPressed: () {
              setState(() {
                _showSettings = true;
              });
            },
          ),

          // Exit Button
          Positioned(
            top: 170,
            right: 10,
            child: GestureDetector(
              onTapDown: (_) => setState(() {
                _scale = 0.9;
                _rotation = 0.02;
              }),
              onTapUp: (_) {
                setState(() {
                  _scale = 1.0;
                  _rotation = 0.0;
                });
                Navigator.pop(context);
              },
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
                    width: 56,
                    height: 56,
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
                          fontSize: 30,
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

          // Settings panel
          if (_showSettings)
            SettingsPanel(
              player: _player,
              currentVolume: _currentVolume,
              onClose: () {
                setState(() {
                  _showSettings = false;
                  _player.setVolume(_currentVolume);
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildShopItem({
    required String image,
    required bool owned,
    required int price,
    required int index,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFB3E5FC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF083B55), width: 3),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),

              // Character image
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Image.asset(
                    image,
                    height: 104,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Bottom section
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: owned ? Colors.green[700] : const Color(0xFF1E88E5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(9),
                    bottomRight: Radius.circular(9),
                  ),
                ),
                child: Center(
                  child: owned
                      ? const Text(
                    'Owned',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),

          // price tag
          if (!owned)
            Positioned(
              bottom: 3,
              child: GestureDetector(
                onTap: () {
                  _handlePurchase(context, index, price);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD54F),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF083B55), width: 2),
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
                      Image.asset('assets/coin.png', height: 18),
                      const SizedBox(width: 4),
                      Text(
                        '$price',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _handlePurchase(BuildContext context, int index, int price) {
    if (userCoins < price) {
      _showSnackBar(context, 'Not enough coins :(', error: true);
      return;
    }

    setState(() {
      userCoins -= price;
      shopItems[index]['owned'] = true;
    });

    _showSnackBar(context, 'Purchase successful!');
  }

  // snackbar
  void _showSnackBar(BuildContext context, String message, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: error ? Colors.redAccent : Colors.green,
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8,
      ),
    );
  }
}
