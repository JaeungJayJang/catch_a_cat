import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import "stack_rpg_game.dart";

void main() {
  final game = StackRPGGame();
  runApp(GameWidget(game: game));
}
