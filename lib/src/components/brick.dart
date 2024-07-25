import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../brick_breaker.dart';
import '../config.dart';

class Brick extends RectangleComponent
    with CollisionCallbacks, HasGameReference<BrickBreaker> {
  int hp;
  Color color = Colors.white;

  Brick({required super.position, required this.hp})
        : super(
            size: Vector2(brickWidth, brickHeight),
            anchor: Anchor.center,
            children: [RectangleHitbox()],
          ) {
      paint = Paint()
        ..color = updateColor(hp)
        ..style = PaintingStyle.fill;
    }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    hp -= 1;
    if (hp <= 0) {
      removeFromParent();
    } else {
      paint.color = updateColor(hp);
    }
  }

  Color updateColor(int hp) {
    return paint.color = brickColors[hp - 1];
  }
}