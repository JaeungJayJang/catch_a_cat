import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:stack_RPG/components/card.dart';
import 'package:stack_RPG/components/character/character.dart';
import 'package:stack_RPG/components/goal/goal.dart';
import 'package:stack_RPG/stack_rpg_game.dart';
import 'package:stack_RPG/components/world/map.dart';

class MainCharacter extends Character {
  MainCharacter({
    super.name,
    super.health,
    super.attack,
    super.interval,
    super.positionX,
    super.positionY,
    super.direction,
  });

  final _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    ..color = Color.fromARGB(255, 64, 194, 203);

  // render
  @override
  void render(Canvas canvas) {
    RRect landRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, width, height),
      const Radius.circular(50.0),
    );

    canvas.drawRRect(landRRect, _borderPaint);
  }

  double timePassed = 0.0;
  @override
  void update(double dt) {
    super.update(dt);

    timePassed += dt;
    if (timePassed >= interval) {
      timePassed = 0.0;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Card) {
      if (other.type == Type.goal) {
        Map map = other.getMap();
        List<int> newRandPos = map.getRandomPosition();
        Goal newGoal = Goal(
          positionX: newRandPos[0],
          positionY: newRandPos[1],
        );
        map.removeCard(other);
        map.addCard(newGoal);
      }
    }
  }
}
