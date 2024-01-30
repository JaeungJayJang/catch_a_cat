import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import "package:flame/game.dart";
import 'package:flame/input.dart';
import 'package:stack_RPG/components/world/map.dart';
import 'package:stack_RPG/overlays/hud.dart';

enum Gesture { up, down, left, right }

// This contains the logic to set up the whole game,
// including the main UI, map, button, etc.
// it inludes the main game loop and logic.

class StackRPGGame extends FlameGame
    with MultiTouchDragDetector, HasCollisionDetection {
  int gameLevel = 1;
  int point = 0;
  bool found = false;

  // variables that define the world and lands on the world.
  // land is where cards are placed
  static const int landCountX = 6;
  static const int landCountY = 6;
  static const double landWidth = 1000.0;
  static const double landHeight = 1000.0;
  static const double landGap = 100.0; // gap between lands

  static const double worldWidth =
      landWidth * landCountX + landGap * (landCountX + 1);
  static const double worldHeight =
      landHeight * landCountY + landGap * (landCountY + 1);

  // variables for gesture detection
  static Vector2 _startPosition = Vector2.zero();
  static Vector2 _endPosition = Vector2.zero();

  static Gesture? gesture;

  static late Map map;

  // refresh
  double interval = 1.0;

  @override
  Future<void> onLoad() async {
    // ------------------------------------------
    // create lands.
    // ------------------------------------------
    map = Map(
      landCountX: landCountX,
      landCountY: landCountY,
      landWidth: landWidth,
      landHeight: landHeight,
      landGap: landGap,
    );

    // ------------------------------------------
    // add components
    // ------------------------------------------
    add(Hud());
    world.add(map);

    // ------------------------------------------
    // set the camera to fix to lands.
    // additional orientations go here.
    // ------------------------------------------
    // set view size relative to map
    camera.viewfinder.visibleGameSize =
        Vector2(worldWidth + 100, worldHeight + 100);

    // set camera to center of map
    camera.viewfinder.position = Vector2(worldWidth / 2, worldHeight / 2);

    // set camera focus to the center
    camera.viewfinder.anchor = Anchor.center;

    camera.debugMode = true;
  }

  double timePassed = 0.0;

  @override
  void update(double dt) {
    super.update(dt);

    if (found) {
      overlays.add('GameOver');
    }
    timePassed += dt;
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onDragStart(int pointerId, DragStartInfo info) {
    _startPosition = info.eventPosition.global;
  }

  @override
  void onDragUpdate(int pointerId, DragUpdateInfo info) {
    _endPosition = info.eventPosition.global;
  }

  @override
  void onDragEnd(int pointerId, DragEndInfo info) {
    double dx = _endPosition[0] - _startPosition[0];
    double dy = _endPosition[1] - _startPosition[1];

    int x = map.mainCharacter.positionX;
    int y = map.mainCharacter.positionY;

    if (dx.abs() > dy.abs()) {
      if (dx > 0) {
        gesture = Gesture.right;
        // print("right");
        if (map.isSafe(x + 1, y)) {
          map.mainCharacter.moveRightBy1();
        }
      } else {
        gesture = Gesture.left;
        // print("left");
        if (map.isSafe(x - 1, y)) {
          map.mainCharacter.moveLeftBy1();
        }
      }
    } else {
      if (dy > 0) {
        gesture = Gesture.down;
        // print("down");
        if (map.isSafe(x, y + 1)) {
          map.mainCharacter.moveDownBy1();
        }
      } else {
        gesture = Gesture.up;
        // print("up");
        if (map.isSafe(x, y - 1)) {
          map.mainCharacter.moveUpBy1();
        }
      }
    }
  }

  void reset() {
    gameLevel = 1;
    point = 0;
    found = false;
    map.removeFromParent();
    map = Map(
      landCountX: landCountX,
      landCountY: landCountY,
      landWidth: landWidth,
      landHeight: landHeight,
      landGap: landGap,
    );
    world.add(map);
  }
}
