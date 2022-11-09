import 'dart:math';

import 'package:flutter/material.dart';

import '../../../items/items_page/items_page.dart';
import '../../../items/models/item/item.dart';
import '../../models/inventory/inventory.dart';

class InventoryCard extends StatelessWidget {
  const InventoryCard({
    super.key,
    required this.inventory,
    required this.onInventoryNameUpdated,
    required this.onInventoryDeleted,
    required this.onAddItem,
    required this.onItemNameUpdate,
    required this.onAddOne,
    required this.onRemoveOne,
  });

  final Inventory inventory;
  final Function(String) onInventoryNameUpdated;
  final Function() onInventoryDeleted;
  final Function(Item) onAddItem;
  final Function(Item, String) onItemNameUpdate;
  final Function(Item, int) onAddOne;
  final Function(Item, int) onRemoveOne;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 8,
                    blurRadius: 10,
                  )
                ],
                border: Border(
                    left: BorderSide(
                        width: 6,
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)]))),
            child: InkWell(
              onTap: () => _onInventoryPressed(context),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#${inventory.id}",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      inventory.name,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const Icon(Icons.arrow_right),
                  ],
                ),
              ),
            )));
  }

  void _onInventoryPressed(BuildContext context) {
    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
        builder: (context) => ItemsPage(
              inventoryName: inventory.name,
              items: inventory.items,
              onInventoryNameUpdated: onInventoryNameUpdated,
              onInventoryDeleted: onInventoryDeleted,
              onAddItem: onAddItem,
              onItemNameUpdated: onItemNameUpdate,
              onAddOne: onAddOne,
              onRemoveOne: onRemoveOne,
            )));
  }
}
