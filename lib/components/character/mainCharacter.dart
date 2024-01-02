import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:stack_RPG/components/card.dart';
import 'package:stack_RPG/components/character/character.dart';
import 'package:stack_RPG/components/goal/goal.dart';
import 'package:stack_RPG/components/world/map.dart';
import 'package:flame/cache.dart';

class MainCharacter extends Character {
  late SpriteAnimationTicker customAnimation;

  MainCharacter({
    super.name,
    super.health,
    super.attack,
    super.interval,
    super.positionX,
    super.positionY,
    super.direction,
    super.animation,
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // final sprites = Sprite.load('characters/cat/Idle.png');

    final spritesSheet = SpriteSheet(
      image: await Images().load("characters/cat/Idle.png"),
      srcSize: Vector2.all(48.0),
    );
    this.animation = spritesSheet.createAnimation(row: 0, stepTime: 0.25);
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

  // render
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    this
        .animationTicker
        ?.getSprite()
        .render(canvas, size: Vector2(width, height));
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
        map.increasePoint();
        map.removeCard(other);
        map.addCard(newGoal);
      }
    }
  }
}
