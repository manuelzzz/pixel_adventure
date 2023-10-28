import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/components/collision_block.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;
  final String character;

  double horizontalMovement = 0;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();

  List<CollisionBlock> collisionBlocks = [];

  Player({
    this.character = 'Nijna Frog',
    Vector2? position,
  }) : super(position: position);

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    debugMode = true;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerState();
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;

    final bool isLeftKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyA) ||
            keysPressed.contains(LogicalKeyboardKey.arrowLeft);

    final bool isRightKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyD) ||
            keysPressed.contains(LogicalKeyboardKey.arrowRight);

    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;

    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation(amount: 11, state: 'Idle');
    runningAnimation = _spriteAnimation(amount: 12, state: 'Run');

    // Set of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
    };

    // Set the current animation
    current = PlayerState.running;
  }

  /// `amount` the number of frames that the .png file have
  ///
  /// `state` like idle, running and hit (see all at /assets/images/Main Characters/)
  SpriteAnimation _spriteAnimation({
    required int amount,
    required String state,
  }) {
    return SpriteAnimation.fromFrameData(
      gameRef.images.fromCache('Main Characters/$character/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  /// Direction is negative, the player moves to left.
  ///
  /// Direction is positive, the player moves to right.
  void _updatePlayerMovement(double dt) {
    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;
  }

  /// Updates the state of character animations based on the velocity
  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    if (velocity.x > 0 || velocity.x < 0) playerState = PlayerState.running;

    current = playerState;
  }
}
