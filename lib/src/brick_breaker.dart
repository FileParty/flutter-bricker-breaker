import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart'; 
import 'package:flame/game.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter/services.dart'; 

import 'components/components.dart';
import 'config.dart' as config;

class BrickBreaker extends FlameGame 
    with HasCollisionDetection, KeyboardEvents, MouseMovementDetector {
  BrickBreaker()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: config.gameWidth,
            height: config.gameHeight,
          ),
        );

  final rand = math.Random(); 
  double get width => size.x;
  double get height => size.y;
  int currentLevel = 0;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    world.add(Ball(
        difficultyModifier: config.difficultyModifier,
        radius: config.ballRadius,
        position: size / 2,
        velocity: Vector2((rand.nextDouble() - 0.5) * width, height * 0.4)
            .normalized()
          ..scale(height / 1.8)));

    world.add(Bat(
        size: Vector2(config.batWidth, config.batHeight),
        cornerRadius: const Radius.circular(config.ballRadius / 2),
        position: Vector2(width / 2, height * 0.95)));


    loadLevel(currentLevel);


    //debugMode = true;
  }

  void loadLevel(int level) {
    // Clear existing bricks
    world.children.whereType<Brick>().forEach((brick) => brick.removeFromParent());

    final bricks = config.brickLevels[level];

    for (var i = 0; i < bricks.length; i++) {
      for (var j = 0; j < bricks[i].length; j++) {
        if (bricks[i][j] > 0) {
          world.add(Brick(
            position: Vector2(
              j * config.brickWidth + (j * 36),
              i * config.brickHeight + (i * 72) + 256,
            ),
            hp: bricks[i][j],
          ));
        }
      }
    }

    // Initialize bat and ball positions
    initializeBatAndBall();
  }

  void initializeBatAndBall() {
    final bat = world.children.query<Bat>().first;
    final ball = world.children.query<Ball>().first;

    bat.position = Vector2(width / 2, height * 0.95);
    ball.position = size / 2;
    ball.velocity = Vector2((rand.nextDouble() - 0.5) * width, height * 0.4).normalized()..scale(height / 2.4);
  }

  void advanceToNextLevel() {
    if (currentLevel < config.brickLevels.length - 1) {
      currentLevel++;
      loadLevel(currentLevel);
    } else {
      // Game completed
      print("All levels completed!");
    }
  }

  void checkAndAdvanceLevel() {
    if (world.children.whereType<Brick>().isEmpty) {
      advanceToNextLevel();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    checkAndAdvanceLevel();
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        world.children.query<Bat>().first.moveBy(-config.batStep);
        break;
      case LogicalKeyboardKey.arrowRight:
        world.children.query<Bat>().first.moveBy(config.batStep);
        break;
    }
    return KeyEventResult.handled;
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    super.onMouseMove(info);
    _moveBatTo(info.eventPosition.global);
  }

  void _moveBatTo(Vector2 position) {
    final bat = world.children.query<Bat>().first;
    double x = position.x * 10;
    if( x >= (width - config.batWidth / 2) ) {
      x = width - config.batWidth / 2;
    } else if( x < config.batWidth / 2 ) {
      x = config.batWidth / 2;
    }
    bat.position.x = x;
  }
}