import 'package:flutter/material.dart';
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
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/game');
              },
              child: const Text('Jogar'),
            ),
            const Divider(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/game');
              },
              child: const Text('Opções'),
            ),
            const Divider(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/game');
              },
              child: const Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
