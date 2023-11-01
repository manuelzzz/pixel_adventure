import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';

class Saw extends SpriteAnimationComponent with HasGameRef<PixelAdventure> {
  final bool isVertical;
  final double offNegative;
  final double offPositive;

  static const double sawSpeed = 0.04;
  static const moveSpeed = 50;
  static const tileSize = 16;

  double moveDirection = 1;
  double rangeNeg = 0;
  double rangePos = 0;

  Saw({
    this.isVertical = false,
    required this.offNegative,
    required this.offPositive,
    super.position,
    super.size,
  });

  @override
  FutureOr<void> onLoad() {
    priority = -1;

    add(CircleHitbox());

    if (isVertical) {
      rangeNeg = position.y - offNegative * tileSize;
      rangePos = position.y + offPositive * tileSize;
    } else {
      rangeNeg = position.x - offNegative * tileSize;
      rangePos = position.x + offPositive * tileSize;
    }

    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Traps/Saw/On (38x38).png'),
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: sawSpeed,
          textureSize: Vector2.all(38),
        ));

    return super.onLoad();
  }

  @override
  void update(double dt) {
    isVertical ? _moveVertically(dt) : _moveHorizontally(dt);

    super.update(dt);
  }

  void _moveVertically(double dt) {
    if (position.y >= rangePos) {
      moveDirection = -1;
    } else if (position.y <= rangeNeg) {
      moveDirection = 1;
    }

    position.y += moveDirection * moveSpeed * dt;
  }

  void _moveHorizontally(double dt) {
    if (position.x >= rangePos) {
      moveDirection = -1;
    } else if (position.x <= rangeNeg) {
      moveDirection = 1;
    }

    position.x += moveDirection * moveSpeed * dt;
  }
}
