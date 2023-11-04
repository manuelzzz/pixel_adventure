import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';

class JumpButton extends SpriteComponent
    with HasGameRef<PixelAdventure>, TapCallbacks {
  JumpButton();

  final spacement = 96;

  @override
  FutureOr<void> onLoad() async {
    priority = 10;
    sprite = Sprite(game.images.fromCache('HUD/JumpButton.png'));

    position = Vector2(game.size.x - spacement, game.size.y - spacement);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player.hasJumped = true;

    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player.hasJumped = false;

    super.onTapUp(event);
  }
}
