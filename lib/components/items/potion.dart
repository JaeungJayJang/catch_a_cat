import 'package:stack_RPG/components/character/character.dart';
import 'package:stack_RPG/components/items/item.dart';
import 'package:stack_RPG/components/card.dart';

class Potion extends Item {
  Potion({
    super.positionX,
    super.positionY,
  }) : super(
          name: "Health Potion",
          type: Type.item,
        );

  @override
  void effect(Card card) {
    if (card is Character) {
      Character character = card;
      character.health += 10;
    }
  }
}
