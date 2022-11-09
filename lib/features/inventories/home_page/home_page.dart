import 'package:flutter/material.dart';

import '../../items/models/item/item.dart';
import '../models/inventory/inventory.dart';
import 'dialogs/inventory_change_dialog.dart';
import 'widgets/inventory_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.title = "Application d'inventaire"});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Inventory> _inventories = [];

  @override
  void initState() {
    super.initState();

    _inventories.addAll(const [
      Inventory(id: "1", name: "Peluches", items: [
        Item(id: "1", name: "Nounourse", qte: 3),
        Item(id: "2", name: "Balaine", qte: 2),
      ]),
      Inventory(id: "2", name: "Légos", items: []),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Inventory App",
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            Flexible(
              child: ListView.separated(
                itemCount: _inventories.length,
                itemBuilder: (context, index) {
                  final inventory = _inventories[index];

                  return InventoryCard(
                    inventory: inventory,
                    onInventoryNameUpdated: (newInventoryName) =>
                        _onInventoryNameUpdate(newInventoryName, index),
                    onInventoryDeleted: () => _onInventoryDeleted(index),
                    onAddItem: (newItem) => _onInventoryItemAdd(newItem, index),
                    onItemNameUpdate: (itemToModify, newName) =>
                        _onItemNameUpdate(itemToModify, newName, index),
                    onAddOne: (itemToModify, newQte) =>
                        _onAddOne(itemToModify, newQte, index),
                    onRemoveOne: (itemToModify, newQte) =>
                        _onAddOne(itemToModify, newQte, index),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onInventoryAdd,
        backgroundColor: Colors.brown,
        shape: const Border(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onInventoryNameUpdate(String newInventoryName, int index) {
    setState(() {
      _inventories[index] =
          _inventories[index].copyWith(name: newInventoryName);
    });
  }

  void _onInventoryDeleted(int index) {
    setState(() {
      _inventories.removeAt(index);
    });
  }

  void _onInventoryItemAdd(Item newItem, int index) {
    setState(() {
      _inventories[index] = _inventories[index]
          .copyWith(items: [..._inventories[index].items, newItem]);
    });
  }

  void _onInventoryAdd() async {
    final String? newName = await showDialog<String?>(
        context: context, builder: (context) => const InventoryChangeDialog());

    if (newName == null) return;

    final Inventory newInventory = Inventory(id: "0", name: newName, items: []);

    setState(() {
      _inventories.add(newInventory);
    });
  }

  void _onItemNameUpdate(Item itemToModify, String newName, int index) {
    setState(() {
      _inventories[index] = _inventories[index].copyWith(items: [
        for (final item in _inventories[index].items)
          if (item.id == itemToModify.id) item.copyWith(name: newName) else item
      ]);
    });
  }

  void _onAddOne(Item itemToModify, int newQte, int index) {
    setState(() {
      _inventories[index] = _inventories[index].copyWith(items: [
        for (final item in _inventories[index].items)
          if (item.id == itemToModify.id) item.copyWith(qte: newQte) else item
      ]);
    });
  }
}
