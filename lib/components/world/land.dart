import 'package:flame/components.dart';

class Land extends PositionComponent {
  double width;
  double height;
  bool reserved;

  Land({
    this.width = 1000.0,
    this.height = 1000.0,
    this.reserved = false,
  }) : super(size: Vector2(width, height));

  // @override
  // bool get debugMode => true;
}
