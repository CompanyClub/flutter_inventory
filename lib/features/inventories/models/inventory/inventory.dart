// Attributs d'un inventaire
// - ID
// - Nom
// - List d'items

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../items/models/item/item.dart';

// required: associates our `inventory.dart` with the code generated by Freezed
part 'inventory.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Inventory with _$Inventory {
  const factory Inventory({
    required String id,
    required String name,
    required List<Item> items,
  }) = _Inventory;
}
