import 'dart:ui';
import 'package:flame/components.dart';
import 'package:stack_RPG/components/card.dart';

class Goal extends Card {
  String? name;
  String? description;

  Goal({
    this.name = "Goal",
    this.description = "Goal",
    super.positionX,
    super.positionY,
  }) : super(
          type: Type.goal,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final sprites = List<int>.generate(10, (i) => i + 1)
        .map((i) => Sprite.load('coin/bronze/Bronze_$i.png'));

    this.animation = SpriteAnimation.spriteList(
      await Future.wait(sprites),
      stepTime: 0.1,
    );
  }

  // render
  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
