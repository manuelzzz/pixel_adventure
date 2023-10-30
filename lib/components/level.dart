import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/components/terrain/collision_block.dart';
import 'package:pixel_adventure/components/actors/player.dart';

class Level extends World {
  final String levelName;
  late TiledComponent level;
  final Player player;
  List<CollisionBlock> collisionBlocks = [];

  Level({
    required this.levelName,
    required this.player,
  });

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(
      '$levelName.tmx',
      Vector2.all(16),
    );

    add(level);

    final spawnpointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnpointsLayer != null) {
      for (final spawnPoint in spawnpointsLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            break;
          default:
        }
      }
    }

    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');

    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        switch (collision.class_) {
          case 'Platform':
            final platform = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              isPlatform: true,
            );

            collisionBlocks.add(platform);
            add(platform);
            break;
          default:
            final terrain = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
            );

            collisionBlocks.add(terrain);
            add(terrain);
        }
      }
    }

    player.collisionBlocks = collisionBlocks;
    return super.onLoad();
  }
}
