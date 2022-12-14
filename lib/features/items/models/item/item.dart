import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';

@freezed
class Item with _$Item {
  const factory Item({
    required String id,
    required String name,
    required int qte,
  }) = _Item;
}
