import 'dart:ui';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:stack_RPG/components/card.dart';
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
    if (x >= 0 && x <= landCountX - 1) {
      if (y >= 0 && y <= landCountY - 1) {
        return true;
      }
    }
    return false;
  }

  Land getLand(int x, int y) {
    try {
      return lands[x][y]!;
    } catch (e) {
      throw Exception("Land not found");
    }
  }

  List<List<int>> getAvailableLands() {
    List<List<int>> entireLands = [];
    for (int i = 0; i < landCountX; i++) {
      for (int j = 0; j < landCountY; j++) {
        entireLands.add([i, j]);
      }
    }

    List<List<int>> objectPosition =
        objects.map((e) => e.getPosition()).toList();

    List<List<int>> availableLand = entireLands
        .where((element) => !objectPosition.contains(element))
        .toList();
    return availableLand;
  }

  List<int> getRandomPosition() {
    Random random = new Random();

    List<List<int>> availableLands = getAvailableLands();

    if (availableLands.length == 0) {
      return [-1, -1];
    } else {
      int randomPos = random.nextInt(availableLands.length);
      return availableLands[randomPos];
    }
  }

  // @override
  // void render(Canvas canvas) {
  //   for (int i = 0; i < landCountX; i++) {
  //     for (int j = 0; j < landCountY; j++) {}
  //   }

  //   super.render(canvas);
  // }

  void addCard(Card card) {
    card.setMap(this);
    objects.add(card);
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
