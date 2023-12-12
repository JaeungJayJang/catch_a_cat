import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:stack_RPG/components/card.dart';
import 'package:stack_RPG/components/goal/goal.dart';

enum Direction { up, right, down, left }

abstract class Character extends Card {
  String? name;
  double health;
  double attack;
  Direction direction;
  double interval;

  Character({
    this.name,
    this.health = 100.0,
    this.attack = 10,
    this.interval = 1.0,
    super.positionX,
    super.positionY,
    Direction? direction,
  })  : direction = direction ??
            Direction.values[Random().nextInt(Direction.values.length)],
        super(type: Type.character);

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

    canvas.drawRRect(
      landRRect,
      _borderPaint,
    );
  }

  void turnLeft() {
    direction = Direction.values[(direction.index - 1) % 4];
  }

  void turnRight() {
    direction = Direction.values[(direction.index + 1) % 4];
  }

  void turnBack() {
    direction = Direction.values[(direction.index + 2) % 4];
  }

  void moveForwardBy1() {
    switch (direction) {
      case Direction.up:
        moveUpBy1();
        break;
      case Direction.right:
        moveRightBy1();
        break;
      case Direction.down:
        moveDownBy1();
        break;
      case Direction.left:
        moveLeftBy1();
        break;
    }
  }

  List<int> getFrontPosition() {
    switch (direction) {
      case Direction.up:
        return [positionX, positionY - 1];
      case Direction.right:
        return [positionX + 1, positionY];
      case Direction.down:
        return [positionX, positionY + 1];
      case Direction.left:
        return [positionX - 1, positionY];
    }
  }

  List<int> getBackPosition() {
    switch (direction) {
      case Direction.up:
        return [positionX, positionY + 1];
      case Direction.right:
        return [positionX - 1, positionY];
      case Direction.down:
        return [positionX, positionY - 1];
      case Direction.left:
        return [positionX + 1, positionY];
    }
  }
}
