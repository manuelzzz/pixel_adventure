import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/game/components/items/checkpoint.dart';
import 'package:pixel_adventure/game/components/items/fruit.dart';
import 'package:pixel_adventure/game/components/terrain/background_tile.dart';
import 'package:pixel_adventure/game/components/terrain/collision_block.dart';
import 'package:pixel_adventure/game/actors/player.dart';
import 'package:pixel_adventure/game/components/traps/saw.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';

class Level extends World with HasGameRef<PixelAdventure> {
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
      priority: -3,
    );

    add(level);

    _scrollingBackground();
    _spawningObjects();
    _addCollisions();

    return super.onLoad();
  }

  Future<void> _scrollingBackground() async {
    final scrollLayer = level.tileMap.getLayer('Scroll');

    if (scrollLayer != null) {
      final scrollBackgroundColor =
          scrollLayer.properties.getValue('BackgroundColor');

      final backgroundTile = BackgroundTile(
        color: scrollBackgroundColor,
        position: Vector2(49, 49),
      );

      await add(backgroundTile);
    }
  }

  void _spawningObjects() {
    final spawnpointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnpointsLayer != null) {
      for (final spawnPoint in spawnpointsLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            break;
          case 'Fruit':
            final fruit = Fruit(
              fruit: spawnPoint.name,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );

            add(fruit);
            break;
          case 'Saw':
            final isVertical = spawnPoint.properties.getValue('isVertical');
            final offNegative = spawnPoint.properties.getValue('offNegative');
            final offPositive = spawnPoint.properties.getValue('offPositive');

            final saw = Saw(
              isVertical: isVertical,
              offNegative: offNegative,
              offPositive: offPositive,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );

            add(saw);
            break;
          case 'Checkpoint':
            final checkPoint = Checkpoint(
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );

            add(checkPoint);
            break;
          default:
        }
      }
    }
  }

  void _addCollisions() {
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
  }
}
