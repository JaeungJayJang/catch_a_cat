import 'dart:ui';
import 'dart:math';
import 'package:collection/collection.dart';

import 'package:flame/components.dart';
import 'package:stack_RPG/components/card.dart';
import 'package:stack_RPG/components/character/character.dart';
import 'package:stack_RPG/components/character/guard.dart';
import 'package:stack_RPG/components/character/mainCharacter.dart';
import 'package:stack_RPG/components/goal/goal.dart';
import 'package:stack_RPG/components/world/land.dart';

class Map extends PositionComponent with HasCollisionDetection {
  // World characteristic
  double width;
  double height;
  double landGap;

  int landCountX;
  int landCountY;

  double landWidth;
  double landHeight;

  List<List<Land?>> lands;

  List<Card> objects = [];

  int point = 0;

  // World constructor
  Map({
    this.landCountX = 5,
    this.landCountY = 5,
    this.landWidth = 1000.0,
    this.landHeight = 1000.0,
    this.landGap = 100.0,
  })  : width = landWidth * landCountX + landGap * (landCountX + 1),
        height = landHeight * landCountY + landGap * (landCountY + 1),
        lands = List.generate(
            landCountX,
            (i) => List.generate(
                landCountY,
                (j) => Land(
                      width: landWidth,
                      height: landHeight,
                    )..position = Vector2(
                        landGap + i * (landWidth + landGap),
                        landGap + j * (landHeight + landGap),
                      ))),
        super(
            size: Vector2(
          landWidth * landCountX + landGap * (landCountX + 1),
          landHeight * landCountY + landGap * (landCountY + 1),
        ));

  final _borderPaint = Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 10
    ..color = Color.fromARGB(255, 255, 188, 112);

  // render
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    RRect landRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, width, height),
      const Radius.circular(50.0),
    );

    canvas.drawRRect(
      landRRect,
      _borderPaint,
    );
  }

  bool isSafe(int x, int y) {
    // Check if the position is in the map
    if (x >= 0 && x <= landCountX - 1) {
      if (y >= 0 && y <= landCountY - 1) {
        return true;
      }
    }
    return false;
  }

  Land getLand(int x, int y) {
    // return land aht position (x, y)
    try {
      return lands[x][y]!;
    } catch (e) {
      throw Exception("Land not found");
    }
  }

  List<List<int>> getAvailableLands() {
    // create NxN matrix for the lands
    List<List<int>> lands =
        List.generate(landCountX, (i) => List.filled(landCountY, 0));

    // mark location where object exist
    objects.forEach((object) => lands[object.positionX][object.positionY] = -1);

    // exceptions:
    List<List<int>> exceptions = [];
    for (int i = 0; i < objects.length; i++) {
      // remove surrounding of main character
      if (objects[i] is MainCharacter) {
        exceptions.addAll(objects[i].getSurroundingPositions());
      }
    }

    // mark location where exceptions exist
    exceptions.forEach((exception) => lands[exception[0]][exception[1]] = -1);

    List<List<int>> availableLands = [];
    for (int i = 0; i < landCountX; i++) {
      for (int j = 0; j < landCountY; j++) {
        if (lands[i][j] == 0) {
          availableLands.add([i, j]);
        }
      }
    }

    return availableLands;
  }

  List<int> getRandomPosition() {
    Random random = new Random();

    List<List<int>> availableLands = getAvailableLands();

    if (availableLands.length == 0) {
      throw Exception("No available land");
    } else {
      int randomPos = random.nextInt(availableLands.length);
      return availableLands[randomPos];
    }
  }

  void addCard(Card card) {
    // set card specific config
    card.setMap(this);
    // set map specific config
    objects.add(card); //keep track of all objects
    add(card);
  }

  void removeCard(Card card) {
    objects.remove(card);
    remove(card);
  }

  void increasePoint() {
    point += 1;
    if (point % 5 == 0) {
      increaseGuardSpeed();
    }
  }

  int getPoint() {
    return point;
  }

  late MainCharacter mainCharacter;

  @override
  Future<void> onLoad() async {
    for (int i = 0; i < landCountX; i++) {
      for (int j = 0; j < landCountY; j++) {
        add(lands[i][j]!);
      }
    }

    // ------------------------------------------
    // create character.
    // ------------------------------------------
    mainCharacter = MainCharacter(
      positionX: (landCountX ~/ 2), // center of the world
      positionY: (landCountY ~/ 2), // center of the world
    );
    addCard(mainCharacter);
  }

  int numGuards = 3;
  static late List<Guard> guards;
  static late Goal goal;

  void increaseGuardSpeed() {
    for (int i = 0; i < numGuards; i++) {
      guards[i].increaseSpeed();
    }
  }

  // refresh
  double interval = 1.0;

  @override
  void onMount() {
    super.onMount();

    // ------------------------------------------
    // create guard.
    // ------------------------------------------
    guards = List<Guard>.filled(numGuards, Guard());
    // guards[0] = Guard(
    //     // positionX: goardPosition[0],
    //     // positionY: goardPosition[1],
    //     positionX: 2,
    //     positionY: 2,
    //     direction: Direction.right);
    // addCard(guards[0]);
    // guards[1] = Guard(
    //     // positionX: goardPosition[0],
    //     // positionY: goardPosition[1],
    //     positionX: 2,
    //     positionY: 2,
    //     direction: Direction.down);
    // addCard(guards[1]);

    for (int i = 0; i < numGuards; i++) {
      try {
        List goardPosition = getRandomPosition();
        guards[i] = Guard(
          positionX: goardPosition[0],
          positionY: goardPosition[1],
        );
        // positionX: 2,
        // positionY: 2);
        addCard(guards[i]);
      } catch (e) {
        print(">> ${i}");
        print("available: ${getAvailableLands().toString()}");
        print(e);
      }
    }

    // ------------------------------------------
    // create goal.
    // ------------------------------------------
    try {
      List goalPosition = getRandomPosition();
      goal = Goal(
        positionX: goalPosition[0],
        positionY: goalPosition[1],
      );
      addCard(goal);
    } catch (e) {
      print(e);
    }
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

    //     if (isSafe(guardFront[0], guardFront[1])) {
    //       guards[i].moveForwardBy1();
    //     } else {
    //       guards[i].turnBack();
    //     }
    //   }
    // }
  }

  // @override
  // bool get debugMode => true;
}
