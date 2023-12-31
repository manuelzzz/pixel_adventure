import 'package:flutter/material.dart';
import 'package:pixel_adventure/game/widgets/pixel_adventure_game_button.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final game = PixelAdventure();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF211F30),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PixelAdventureGameButton(
              name: 'Play',
              onPressed: () => Navigator.of(context).pushNamed('/levels'),
            ),
            const SizedBox(height: 20),
            PixelAdventureGameButton(
              name: 'Settings',
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            PixelAdventureGameButton(
              name: 'Close',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
