import 'package:flutter/material.dart';
import 'package:pixel_adventure/app/widgets/pixel_adventure_game_button.dart';

class LevelsPage extends StatefulWidget {
  const LevelsPage({super.key});

  @override
  State<LevelsPage> createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF211F30),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: PixelAdventureGameButton(
          onPressed: () => Navigator.of(context).pop(),
          name: 'Back',
        ),
        leadingWidth: 75,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pushNamed('/game'),
          child: const Text('Level 1'),
        ),
      ),
    );
  }
}
