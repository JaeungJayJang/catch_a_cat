import 'dart:ui';
import 'package:stack_RPG/components/card.dart';

abstract class Item extends Card {
  String? name;
  String? description;

  Item({
    this.name,
    this.description,
    super.positionX,
    super.positionY,
    super.type,
  });

  void effect(Card card);

  final _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    ..color = Color.fromARGB(255, 255, 19, 35);

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
}
