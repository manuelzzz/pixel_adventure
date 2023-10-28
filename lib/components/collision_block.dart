import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  bool isPlatform;

  CollisionBlock({
    required position,
    required size,
    this.isPlatform = false,
  }) : super(
          position: position,
          size: size,
        );
}
