import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

class PixelAdventureLevelButton extends StatelessWidget {
  final int levelIndex;

  const PixelAdventureLevelButton({
    super.key,
    required this.levelIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SpriteButton.asset(
      path: "Menu/Levels/$levelIndex.png",
      pressedPath: "Menu/Levels/$levelIndex.png",
      onPressed: () => Navigator.of(context).pushNamed(
        '/game',
        arguments: levelIndex,
      ),
      width: 70,
      height: 70,
      label: const Text(''),
    );
  }
}
