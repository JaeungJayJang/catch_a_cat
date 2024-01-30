import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:stack_RPG/overlays/game_over.dart';
import 'package:stack_RPG/overlays/main_menu.dart';
import "stack_rpg_game.dart";

void main() {
  runApp(GameWidget<StackRPGGame>.controlled(
    gameFactory: StackRPGGame.new,
    overlayBuilderMap: {
      'MainMenu': (_, game) => MainMenu(game: game),
      'GameOver': (_, game) => GameOver(game: game)
    },
    initialActiveOverlays: const ['MainMenu'],
  ));
}
