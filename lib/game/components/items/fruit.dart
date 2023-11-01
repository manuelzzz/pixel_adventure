import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pixel_adventure/game/utils/custom_hitbox.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';

class Fruit extends SpriteAnimationComponent
    with HasGameRef<PixelAdventure>, CollisionCallbacks {
  final String fruit;

  Fruit({
    this.fruit = 'Apple',
    super.position,
    super.size,
  });

  final double stepTime = 0.05;

  final hitbox = CustomHitbox(
    offsetX: 10,
    offsetY: 10,
    width: 12,
    height: 12,
  );
  bool _collected = false;

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    // debugMode = true;

    add(
      RectangleHitbox(
        position: Vector2(hitbox.offsetX, hitbox.offsetY),
        size: Vector2(hitbox.width, hitbox.height),
        collisionType: CollisionType.passive,
      ),
    );

    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Items/Fruits/$fruit.png'),
      SpriteAnimationData.sequenced(
        amount: 17,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );

    return super.onLoad();
  }

  void playerTouch() async {
    if (!_collected) {
      animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Items/Fruits/Collected.png'),
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: stepTime,
          textureSize: Vector2.all(32),
          loop: false,
        ),
      );

      _collected = true;

      await animationTicker?.completed;

      removeFromParent();
    }
  }
}
