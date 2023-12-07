import 'dart:ui';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:stack_RPG/components/card.dart';
import 'package:stack_RPG/components/character/mainCharacter.dart';
import 'package:stack_RPG/components/world/land.dart';

class Map extends PositionComponent {
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
    print(exceptions);

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

  @override
  Future<void> onLoad() async {
    for (int i = 0; i < landCountX; i++) {
      for (int j = 0; j < landCountY; j++) {
        add(lands[i][j]!);
      }
    }
  }

  // @override
  // bool get debugMode => true;
}
