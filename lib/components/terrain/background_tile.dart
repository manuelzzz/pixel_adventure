import 'dart:async';

import 'package:flame/components.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class BackgroundTile extends SpriteComponent with HasGameRef<PixelAdventure> {
  final String color;
  final double scrollSpeed = 0.4;

  BackgroundTile({
    this.color = 'Gray',
    super.position,
  });

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    sprite = Sprite(game.images.fromCache('Background/$color.png'));

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += scrollSpeed;

    const tileSize = 64.0;
    int scrollHeight = (game.size.y / tileSize).floor();

    if (position.y > scrollHeight * tileSize) {
      position.y = -tileSize;
    }

    super.update(dt);
  }
}
