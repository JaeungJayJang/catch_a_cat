import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import '../stack_rpg_game.dart';

class Hud extends PositionComponent with HasGameReference<StackRPGGame> {
  Hud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  });

  late TextComponent _levelTextComponent;
  late TextComponent _scoreTextComponent;

  @override
  Future<void> onLoad() async {
    _levelTextComponent = TextComponent(
      text: 'level: ${game.gameLevel}',
      textRenderer: TextPaint(
        style: TextStyle(
          color: BasicPalette.white.color,
          fontSize: 24,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(60, 60),
    );
    _scoreTextComponent = TextComponent(
      text: 'point: ${game.point}',
      textRenderer: TextPaint(
        style: TextStyle(
          color: BasicPalette.white.color,
          fontSize: 24,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x - 60, 60),
    );

    add(_levelTextComponent);
    add(_scoreTextComponent);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _levelTextComponent.text = 'level: ${game.gameLevel}';
    _scoreTextComponent.text = 'point: ${game.point}';
  }
}
