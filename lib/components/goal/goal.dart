import 'dart:ui';
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
