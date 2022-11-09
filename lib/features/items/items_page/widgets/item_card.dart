import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_inventory/features/items/items_page/dialogs/item_change_dialog.dart';

import '../../models/item/item.dart';

class ItemCard extends StatefulWidget {
  const ItemCard(
      {super.key,
      required this.item,
      required this.onItemNameUpdated,
      required this.onAddOne,
      required this.onRemoveOne});

  final Item item;

  final Function(Item, String) onItemNameUpdated;
  final Function(Item, int) onAddOne;
  final Function(Item, int) onRemoveOne;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late String _itemName;
  late int _itemQte;

  @override
  void initState() {
    super.initState();

    _itemName = widget.item.name;
    _itemQte = widget.item.qte;
  }

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
                top: BorderSide(
                    width: 6,
                    color: Colors.primaries[
                        Random().nextInt(Colors.primaries.length)]))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                _itemName,
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                "Quantité : $_itemQte",
                style: Theme.of(context).textTheme.headline2,
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RawMaterialButton(
                      onPressed: _removeOne,
                      fillColor: Colors.white,
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                    ),
                    RawMaterialButton(
                      onPressed: _addOne,
                      fillColor: Colors.white,
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                    RawMaterialButton(
                      onPressed: _onEditItemName,
                      fillColor: Colors.white,
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _removeOne() async {
    if (_itemQte <= 0) return;
    final int newQte = _itemQte - 1;

    widget.onRemoveOne(widget.item, newQte);

    setState(() {
      _itemQte = newQte;
    });
  }

  Future _addOne() async {
    final int newQte = _itemQte + 1;
    widget.onAddOne(widget.item, newQte);

    setState(() {
      _itemQte = newQte;
    });
  }

  Future _onEditItemName() async {
    final String? newName = await showDialog<String?>(
        context: context,
        builder: (context) => ItemChangeDialog(
              itemName: _itemName,
            ));

    if (newName == null) return;

    widget.onItemNameUpdated(widget.item, newName);

    setState(() {
      _itemName = newName;
    });
  }
}
