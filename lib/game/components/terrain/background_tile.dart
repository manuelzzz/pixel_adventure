import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class BackgroundTile extends ParallaxComponent {
  final String color;
  final double scrollSpeed = 40;

  BackgroundTile({
    this.color = 'Gray',
    super.position,
  }) : super(scale: Vector2.all(1), size: Vector2(1, 1));

  @override
  FutureOr<void> onLoad() async {
    priority = -20;
    // 516
    size = Vector2(540, 256);

    parallax = await game.loadParallax(
      [ParallaxImageData('Background/$color.png')],
      baseVelocity: Vector2(0, -scrollSpeed),
      repeat: ImageRepeat.repeat,
      fill: LayerFill.none,
    );

    return super.onLoad();
  }
}
