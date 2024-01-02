import 'dart:ui';

import 'package:flame/components.dart';

class Land extends PositionComponent {
  double width;
  double height;

  Land({
    this.width = 1000.0,
    this.height = 1000.0,
  }) : super(size: Vector2(width, height));

  // @override
  // bool get debugMode => true;

  final _borderPaint = Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 10
    ..color = Color.fromARGB(255, 255, 161, 53);

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
