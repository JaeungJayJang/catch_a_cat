import 'package:flame/components.dart';
import "package:flame/game.dart";
import 'components/land.dart';

class StackRPGGame extends FlameGame {
  static const double landWidth = 1000.0;
  static const double landHeight = 1000.0;
  static const double landGap = 100.0;
  static const double landRadius = 1000.0;
  static final Vector2 landSize = Vector2(landWidth, landHeight);

  static const int mapWidth = 3;
  static const int mapHeight = 3;

  @override
  Future<void> onLoad() async {
    // create n*n world that is consist of land block
    for (int i = 0; i < mapWidth; i++) {
      for (int j = 0; j < mapHeight; j++) {
        final land = Land()
          ..size = landSize
          ..position = Vector2(
            landGap + i * (landWidth + landGap),
            landGap + j * (landHeight + landGap),
          );
        world.add(land);
      }
    }

    // set view size relative to map
    camera.viewfinder.visibleGameSize = Vector2(
      landWidth * mapWidth + landGap * (mapWidth + 1),
      landHeight * mapHeight + landGap * (mapHeight + 1),
    );

    // set camera to center of map
    camera.viewfinder.position = Vector2(
      landWidth * mapWidth / 2 + landGap * (mapWidth + 1) / 2,
      landHeight * mapHeight / 2 + landGap * (mapHeight + 1) / 2,
    );

    // set camera focus to the center
    camera.viewfinder.anchor = Anchor.center;
  }
}
