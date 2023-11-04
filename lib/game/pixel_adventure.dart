import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/game/actors/player.dart';
import 'package:pixel_adventure/game/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection {
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  final Map<int, String> levelNames = {
    1: 'Level-1',
    2: 'Level-2',
  };

  int levelIndex = 0;

  late JoystickComponent joystick;
  late CameraComponent cam;

  Player player = Player(character: 'Mask Dude');
  bool showHud = false;

  @override
  void onAttach() {
    if (buildContext != null) {
      levelIndex = ModalRoute.of(buildContext!)!.settings.arguments as int;
    }

    _loadLevel();

    super.onAttach();
  }

  @override
  Future<void> onLoad() async {
    await images.loadAllImages();

    if (showHud) {
      addJoystick();
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showHud) {
      updateJoystick();
    }

    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      priority: 10,
      knob: SpriteComponent(
        sprite: Sprite(images.fromCache('HUD/Knob.png')),
      ),
      background:
          SpriteComponent(sprite: Sprite(images.fromCache('HUD/Joystick.png'))),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );

    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
      case JoystickDirection.left:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
      case JoystickDirection.right:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

  void loadNextLevel() {
    if (levelIndex < levelNames.length && buildContext != null) {
      levelIndex++;

      Navigator.of(buildContext!).pushReplacementNamed(
        '/game',
        arguments: levelIndex,
      );
    } else {}
  }

  void _loadLevel() {
    final world = Level(
      levelName: levelNames[levelIndex]!,
      player: player,
    );

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: 640,
      height: 360,
    );

    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);
  }
}
