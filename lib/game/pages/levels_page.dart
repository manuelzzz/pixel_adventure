import 'package:flutter/material.dart';
import 'package:pixel_adventure/game/widgets/pixel_adventure_game_button.dart';
import 'package:pixel_adventure/game/widgets/pixel_adventure_level_button.dart';

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
      body: const Center(
        child: Row(
          children: [
            PixelAdventureLevelButton(levelIndex: 01),
            PixelAdventureLevelButton(levelIndex: 02),
          ],
        ),
      ),
    );
  }
}
