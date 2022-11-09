import 'package:flutter/material.dart';

import '../models/item/item.dart';
import 'dialogs/item_change_dialog.dart';
import 'dialogs/inventory_name_dialog.dart';
import 'widgets/item_card.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage(
      {super.key,
      required this.inventoryName,
      required this.items,
      required this.onInventoryNameUpdated,
      required this.onInventoryDeleted,
      required this.onAddItem,
      required this.onItemNameUpdated,
      required this.onAddOne,
      required this.onRemoveOne});

  final String inventoryName;
  final List<Item> items;

  final Function(String) onInventoryNameUpdated;
  final Function() onInventoryDeleted;
  final Function(Item) onAddItem;
  final Function(Item, String) onItemNameUpdated;
  final Function(Item, int) onAddOne;
  final Function(Item, int) onRemoveOne;

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  late String _inventoryName;
  final List<Item> _items = [];

  @override
  void initState() {
    super.initState();

    _inventoryName = widget.inventoryName;
    _items.addAll(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Titre
            Text(_inventoryName, style: Theme.of(context).textTheme.headline1),

            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              RawMaterialButton(
                onPressed: _onEditInventoryName,
                fillColor: Colors.brown,
                padding: const EdgeInsets.all(15.0),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
              RawMaterialButton(
                onPressed: _onDeleteInventory,
                fillColor: Colors.red,
                padding: const EdgeInsets.all(15.0),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ]),

            const SizedBox(
              height: 16,
            ),

            // Liste des items
            Flexible(
                child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 300,
                maxCrossAxisExtent: 430,
              ),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final Item item = _items[index];

                return ItemCard(
                  item: item,
                  onItemNameUpdated: widget.onItemNameUpdated,
                  onAddOne: widget.onAddOne,
                  onRemoveOne: widget.onRemoveOne,
                );
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddItem,
        backgroundColor: Colors.blueAccent,
        shape: const Border(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future _onEditInventoryName() async {
    final String? newName = await showDialog<String?>(
        context: context,
        builder: (context) => InventoryNameDialog(
              inventoryName: _inventoryName,
            ));

    if (newName == null) return;

    widget.onInventoryNameUpdated(newName);

    setState(() {
      _inventoryName = newName;
    });
  }

  Future _onDeleteInventory() async {
    widget.onInventoryDeleted();

    Navigator.of(context).pop();
  }

  Future _onAddItem() async {
    final String? newName = await showDialog<String?>(
        context: context, builder: (context) => const ItemChangeDialog());

    if (newName == null) return;

    final Item newItem = Item(id: "0", name: newName, qte: 0);

    widget.onAddItem(newItem);

    setState(() {
      _items.add(newItem);
    });
  }
}
