import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:stack_RPG/components/character/character.dart';
import 'package:stack_RPG/components/character/mainCharacter.dart';
import 'package:flame/cache.dart';

class Guard extends Character {
  late Sight sight;

  Guard({
    super.name,
    super.health,
    super.attack,
    super.interval,
    super.positionX,
    super.positionY,
    super.direction,
    super.animation,
  });

  final _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    ..color = Color.fromARGB(255, 23, 99, 161);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final spriteSheet = SpriteSheet(
      image: await Images().load("characters/dog/Idle.png"),
      srcSize: Vector2.all(48.0),
    );
    this.animation = spriteSheet.createAnimation(row: 0, stepTime: 0.25);

    sight = Sight(
      width: 1000,
      height: 1000,
    );

    add(sight);
  }

  // render
  @override
  void render(Canvas canvas) {
    super.render(canvas);

    RRect landRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, width, height),
      const Radius.circular(50.0),
    );

    canvas.drawRRect(landRRect, _borderPaint);
  }

  void setSightPosition() {
    switch (direction) {
      case Direction.up:
        sight.setPosition(0, -1);
        break;
      case Direction.down:
        sight.setPosition(0, 1);
        break;
      case Direction.left:
        sight.setPosition(-1, 0);
        break;
      case Direction.right:
        sight.setPosition(1, 0);
        break;
    }
  }

  void increaseSpeed() {
    interval *= 5 / 6;
  }

  double timePassed = 0.0;
  @override
  void update(double dt) {
    super.update(dt);

    timePassed += dt;

    // continuous events
    setSightPosition();

    // timed events
    if (timePassed >= interval) {
      timePassed = 0.0;

      // setSightPosition();

      List<int> frontPosition = getFrontPosition();
      if (super.map!.isSafe(frontPosition[0], frontPosition[1])) {
        if (sight.seenObject is Guard) {
          this.turnBack();
        } else if (sight.seenObject is MainCharacter) {
          print("Game over!");
          throw new Exception("Game over!");
        } else if (sight.seenObject is Sight) {
          this.turnBack();
          // if (direction.index % 2 == 0) {
          //   // up or down
          //   this.turnBack();
          // }
        } else {
          this.moveForwardBy1();
        }

        // if (sight.seeGuard) {
        //   this.turnBack();
        // }
        // if (sight.seeObject) {
        //   if (direction.index % 2 == 0) {
        //     this.turnBack();
        //   }
        // }
      } else {
        this.turnBack();
      }
    }
  }

  // @override
  // void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
  //   super.onCollision(intersectionPoints, other);
  //   print("collision");
  // }
}

class Sight extends PositionComponent with CollisionCallbacks {
  double width;
  double height;
  int positionX;
  int positionY;

  var seenObject;

  final Color _defaultColor = Color.fromARGB(255, 175, 175, 175);
  late final defaultPaint;
  late final RectangleHitbox hitbox;

  Sight({
    this.width = 1000.0,
    this.height = 1000.0,
    this.positionX = 0,
    this.positionY = 0,
  }) : super(
          size: Vector2(width, height),
          position: new Vector2(
            positionX * width,
            positionY * height,
          ),
        );

  void setPosition(x, y) {
    positionX = x;
    positionY = y;
    position = Vector2(
      positionX * width,
      positionY * height,
    );
  }

  void setUp() {
    setPosition(0, -1);
  }

  void setDown() {
    setPosition(0, 1);
  }

  void setLeft() {
    setPosition(-1, 0);
  }

  void setRight() {
    setPosition(1, 0);
  }

  @override
  Future<void> onLoad() async {
    defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;
    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true
      ..isSolid = true;
    add(hitbox);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Guard) {
      if (other.sight != this) {
        seenObject = other;
      }
    }
    if (other is Sight) {
      seenObject = other;
    }
    if (other is MainCharacter) {
      seenObject = other;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    seenObject = null;
  }

  // @override
  // bool get debugMode => true;
}
