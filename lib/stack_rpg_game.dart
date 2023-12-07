import 'package:flame/components.dart';
import 'package:flame/events.dart';
import "package:flame/game.dart";
import 'package:flame/input.dart';
import 'package:stack_RPG/components/world/map.dart';

enum Gesture { up, down, left, right }

// This contains the logic to set up the whole game,
// including the main UI, map, button, etc.
// it inludes the main game loop and logic.

class StackRPGGame extends FlameGame
    with MultiTouchDragDetector, HasCollisionDetection {
  static int gameLevel = 1;

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
    world.add(map);

    // ------------------------------------------
    // set the camera to fix to lands.
    // additional orientations go here.
    // ------------------------------------------
    // set view size relative to map
    camera.viewfinder.visibleGameSize = Vector2(worldWidth, worldHeight);

    // set camera to center of map
    camera.viewfinder.position = Vector2(worldWidth / 2, worldHeight / 2);

    // set camera focus to the center
    camera.viewfinder.anchor = Anchor.center;
  }

  double timePassed = 0.0;

  @override
  void update(double dt) {
    super.update(dt);

    timePassed += dt;

    // // continuous event
    // for (int i = 0; i < numGuards; i++) {
    //   List guardFront = guards[i].getFrontPosition();
    //   if (ListEquality()
    //           .equals(guards[i].getPosition(), mainCharacter.getPosition()) ||
    //       ListEquality().equals(guardFront, mainCharacter.getPosition())) {
    //     print("main Character found!");
    //   }
    // }

    // // timed event
    // if (timePassed >= interval) {
    //   timePassed = 0.0;

    //   for (int i = 0; i < numGuards; i++) {
    //     List guardFront = guards[i].getFrontPosition();

    //     if (map.isSafe(guardFront[0], guardFront[1])) {
    //       guards[i].moveForwardBy1();
    //     } else {
    //       guards[i].turnBack();
    //     }
    //   }
    // }
    // if (guard.direction == Direction.up && guard.positionY == 0) {
    //   guard.facingBack();
    // } else if (guard.direction == Direction.down &&
    //     guard.positionY == landCountY - 1) {
    //   guard.facingBack();
    // } else if (guard.direction == Direction.left && guard.positionX == 0) {
    //   guard.facingBack();
    // } else if (guard.direction == Direction.right &&
    //     guard.positionX == landCountX - 1) {
    //   guard.facingBack();
    // }
    // print("update");
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

    // // create new item at random position and add to the world
    // Potion newItem = Potion(
    //   positionX: _randomPosition()[0],
    //   positionY: _randomPosition()[1],
    // );

    // world.add(newItem);
  }
}


  // // variables that define the world and lands on the worlds.
  // static const double landWidth = 1000.0;
  // static const double landHeight = 1000.0;
  // static const double landGap = 100.0;
  // static const double landRadius = 50.0;
  // static final Vector2 landSize = Vector2(landWidth, landHeight);
  // static final landRRect = RRect.fromRectAndRadius(
  //   const Rect.fromLTWH(0, 0, landWidth, landHeight),
  //   const Radius.circular(landRadius),
  // );

  // // size of world: numb of lands
  // static const int worldWidth = 5;
  // static const int worldHeight = 5;

  // static Vector2 _startPosition = Vector2.zero();
  // static Vector2 _endPosition = Vector2.zero();

  // static String gesture = "";

  // static late Character mainCharacter;
  // static late Character enemy;

  // List _reserved = [];

  // /// generate random position that is not reserved.
  // /// return [-1, -1] if all positions are reserved.
  // List _randomPosition() {
  //   Random random = new Random();

  //   if (_reserved.length != worldWidth * worldHeight) {
  //     int x = random.nextInt(worldWidth);
  //     int y = random.nextInt(worldHeight);

  //     while (_reserved.contains([x, y])) {
  //       x = random.nextInt(worldWidth);
  //       y = random.nextInt(worldHeight);
  //     }

  //     _reserved.add([x, y]);
  //     return [x, y];
  //   } else {
  //     return [-1, -1];
  //   }
  // }

  // @override
  // Future<void> onLoad() async {
  //   // ------------------------------------------
  //   // create lands.
  //   // This should just show the locations where the components can be placed.
  //   // ------------------------------------------
  //   // create n*n world that is consist of land block
  //   for (int i = 0; i < worldWidth; i++) {
  //     for (int j = 0; j < worldHeight; j++) {
  //       final land = Land()
  //         ..size = landSize
  //         ..position = Vector2(
  //           landGap + i * (landWidth + landGap),
  //           landGap + j * (landHeight + landGap),
  //         );
  //       world.add(land);
  //     }
  //   }

  //   // ------------------------------------------
  //   // create character.
  //   // ------------------------------------------
  //   // variables
  //   List mainCharacterPosition = [
  //     (worldWidth / 2).floor(),
  //     (worldHeight / 2).floor()
  //   ];
  //   mainCharacter = Character()
  //     ..position = Vector2(
  //       (landWidth + landGap) * mainCharacterPosition[0] + landGap,
  //       (landHeight + landGap) * mainCharacterPosition[1] + landGap,
  //     );
  //   world.add(mainCharacter);

  //   List mobPosition = _randomPosition();
  //   print(mobPosition);
  //   final mob = Character()
  //     ..position = Vector2(
  //       (landWidth + landGap) * (mobPosition[0]) + landGap,
  //       (landHeight + landGap) * (mobPosition[1]) + landGap,
  //     );
  //   world.add(mob);

  //   // ------------------------------------------
  //   // add main game logic here.
  //   // ------------------------------------------

  //   // ------------------------------------------
  //   // set the camera to fix to lands.
  //   // additional orientations go here.
  //   // ------------------------------------------
  //   // set view size relative to map
  //   camera.viewfinder.visibleGameSize = Vector2(
  //     landWidth * worldWidth + landGap * (worldWidth + 1),
  //     landHeight * worldHeight + landGap * (worldHeight + 1),
  //   );

  //   // set camera to center of map
  //   camera.viewfinder.position = Vector2(
  //     landWidth * worldWidth / 2 + landGap * (worldWidth + 1) / 2,
  //     landHeight * worldHeight / 2 + landGap * (worldHeight + 1) / 2,
  //   );

  //   // set camera focus to the center
  //   camera.viewfinder.anchor = Anchor.center;
  // }

  // @override
  // void onDragStart(int pointerId, DragStartInfo info) {
  //   _startPosition = info.eventPosition.global;
  //   // print(info.eventPosition.global);
  // }

  // @override
  // void onDragUpdate(int pointerId, DragUpdateInfo info) {
  //   _endPosition = info.eventPosition.global;
  //   // print(info.eventPosition.global);
  //   // print("update");
  // }

  // @override
  // void onDragEnd(int pointerId, DragEndInfo info) {
  //   double dx = _endPosition[0] - _startPosition[0];
  //   double dy = _endPosition[1] - _startPosition[1];

  //   if (dx.abs() > dy.abs()) {
  //     if (dx > 0) {
  //       gesture = "right";
  //       print("right");
  //       mainCharacter.moveRightBy1();
  //     } else {
  //       gesture = "left";
  //       print("left");
  //       mainCharacter.moveLeftBy1();
  //     }
  //   } else {
  //     if (dy > 0) {
  //       gesture = "down";
  //       print("down");
  //       mainCharacter.moveDownBy1();
  //     } else {
  //       gesture = "up";
  //       print("up");
  //       mainCharacter.moveUpBy1();
  //     }
  //   }
  // }
