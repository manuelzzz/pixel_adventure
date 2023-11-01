import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:pixel_adventure/app/pages/home_page.dart';
import 'package:pixel_adventure/app/pages/levels_page.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(
    MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (context) => HomePage(),
        '/levels': (context) => const LevelsPage(),
        '/game': (context) => GameWidget(game: PixelAdventure()),
      },
    ),
  );
}
